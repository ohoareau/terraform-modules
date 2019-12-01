resource "aws_vpc" "vpc" {
  count      = var.enabled ? 1 : 0
  cidr_block = var.cidr_block
  tags       = {
    Env = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "subnet" {
  for_each   = var.enabled ? var.subnets : {}
  vpc_id     = var.enabled ? aws_vpc.vpc[0].id : null
  cidr_block = var.enabled ? lookup(each.value, "cidr_block", var.cidr_block) : null
  tags       = {
    Env = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "allow_inbound_trafic" {
  for_each = var.enabled ? var.security_groups : {}
  name     = var.enabled ? "${var.env}-${aws_vpc.vpc[0].id}-${each.key}" : null
  vpc_id   = var.enabled ? aws_vpc.vpc[0].id : null
  dynamic "egress" {
    iterator = e
    for_each = (0 < length(lookup(each.value, "egress", []))) ? {egress: lookup(each.value, "egress", [])} : {}
    content {
      from_port   = lookup(e.value, "from_port", 0)
      to_port     = lookup(e.value, "to_port", 0)
      protocol    = lookup(e.value, "protocol", "-1")
      cidr_blocks = lookup(e.value, "cidr_blocks", ["0.0.0.0/0"])
    }
  }
}
