provider "aws" {
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  subnet_names = tolist(keys(var.subnets)) // => ["primary", "secondary", "tertiary"]
  azs_map      = {for k,v in data.aws_availability_zones.available.names: local.subnet_names[k] => v}
}

resource "aws_subnet" "private-subnet" {
  for_each   = var.subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = lookup(each.value, "cidr_block", var.cidr_block)
  availability_zone = local.azs_map[each.key]
  lifecycle {
    create_before_destroy = true
  }
}