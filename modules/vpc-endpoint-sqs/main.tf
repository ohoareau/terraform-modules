provider "aws" {
}

data "aws_vpc_endpoint_service" "service" {
  service = "sqs"
}

resource "aws_vpc_endpoint" "service" {
  vpc_id              = var.vpc_id
  service_name        = data.aws_vpc_endpoint_service.service.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.security_group_ids
  subnet_ids          = var.subnet_ids
  private_dns_enabled = var.private_dns_enabled
}
