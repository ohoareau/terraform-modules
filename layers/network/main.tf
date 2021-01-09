provider "aws" {
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.dns_hostnames
  enable_dns_support   = var.dns_support
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  subnet_names = tolist(keys(var.subnets))
  azs_map      = {for k,v in data.aws_availability_zones.available.names: local.subnet_names[k] => v}
  name         = format("%s-%s-sg", var.env, var.name)
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "private-subnet" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = lookup(each.value, "cidr_block", var.cidr_block)
  availability_zone = local.azs_map[each.key]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private" {
  for_each       = var.subnets
  subnet_id      = aws_subnet.private-subnet[each.key].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "default" {
  count       = true == var.security_group ? 1 : 0
  vpc_id      = aws_vpc.vpc.id
  name        = local.name
  description = format("Security Group for %s", local.name)
  lifecycle {
    create_before_destroy = true
  }
}
