locals {
  public_subnets = {for k,s in var.subnets: k => s if s.public == true}
  private_subnets = {for k,s in var.subnets: k => s if s.public == false}
  has_public = 0 < length(local.public_subnets)
  has_private = 0 < length(local.private_subnets)
}

resource "aws_vpc" "vpc" {
  count      = var.enabled ? 1 : 0
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.dns_hostnames
  enable_dns_support   = var.dns_support
  tags       = {
    Env = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "gw" {
  count  = (var.enabled && local.has_public) ? 1 : 0
  vpc_id = var.enabled ? aws_vpc.vpc[0].id : null
}

resource "aws_route" "internet_access" {
  count                  = (var.enabled && local.has_public) ? 1 : 0
  route_table_id         = var.enabled ? aws_vpc.vpc[0].main_route_table_id : null
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = (var.enabled && local.has_public) ? aws_internet_gateway.gw[0].id : null
}

resource "aws_subnet" "public-subnet" {
  for_each   = var.enabled ? local.public_subnets : {}
  vpc_id     = var.enabled ? aws_vpc.vpc[0].id : null
  cidr_block = var.enabled ? (("" != lookup(each.value, "cidr_block", var.cidr_block)) ? lookup(each.value, "cidr_block", var.cidr_block) : var.cidr_block) : null
  tags       = {
    Env = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private-subnet" {
  for_each   = var.enabled ? local.private_subnets : {}
  vpc_id     = var.enabled ? aws_vpc.vpc[0].id : null
  cidr_block = var.enabled ? (("" != lookup(each.value, "cidr_block", var.cidr_block)) ? lookup(each.value, "cidr_block", var.cidr_block) : var.cidr_block) : null
  tags       = {
    Env = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "gw" {
  for_each   = (var.enabled && local.has_private) ? local.public_subnets : {}
  vpc        = true
  depends_on = [aws_internet_gateway.gw[0]]
}

resource "aws_nat_gateway" "gw" {
  for_each      = (var.enabled && local.has_private) ? local.public_subnets : {}
  subnet_id     = var.enabled ? aws_subnet.public-subnet[each.key].id : null
  allocation_id = var.enabled ? aws_eip.gw[each.key].id : null
}


resource "aws_route_table" "private" {
  for_each = var.enabled ? local.private_subnets : {}
  vpc_id   = var.enabled ? aws_vpc.vpc[0].id : null
  route {
    cidr_block     = "0.0.0.0/0"
    // hard coded to use nat gateway of *first public subnet* for all private subnets...
    nat_gateway_id = var.enabled ? aws_nat_gateway.gw[keys(aws_nat_gateway.gw)[0]].id : null
  }
}

resource "aws_route_table_association" "private" {
  for_each       = var.enabled ? local.private_subnets : {}
  subnet_id      = var.enabled ? aws_subnet.private-subnet[each.key].id : null
  route_table_id = var.enabled ? aws_route_table.private[each.key].id : null
}

resource "aws_security_group" "security_group" {
  for_each = var.enabled ? var.security_groups : {}
  name     = var.enabled ? "${var.env}-${aws_vpc.vpc[0].id}-${each.key}" : null
  vpc_id   = var.enabled ? aws_vpc.vpc[0].id : null
  dynamic "egress" {
    iterator = e
    for_each = (0 < length(lookup(each.value, "egress", []))) ? {for k,v in lookup(each.value, "egress", []): k => v} : {}
    content {
      from_port   = lookup(e.value, "from_port", 0)
      to_port     = lookup(e.value, "to_port", 0)
      protocol    = lookup(e.value, "protocol", "-1")
      cidr_blocks = lookup(e.value, "cidr_blocks", ["0.0.0.0/0"])
    }
  }
}
