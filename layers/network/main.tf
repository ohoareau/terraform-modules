provider "aws" {
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private-subnet" {
  for_each   = toset([for s in keys(var.subnets): s])
  vpc_id     = aws_vpc.vpc.id
  cidr_block = lookup(var.subnets[each.value], "cidr_block", var.cidr_block)
  availability_zone = data.aws_availability_zones.available.names[each.key]
  lifecycle {
    create_before_destroy = true
  }
}