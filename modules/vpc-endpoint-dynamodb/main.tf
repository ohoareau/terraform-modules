provider "aws" {
}

data "aws_vpc_endpoint_service" "service" {
  service = "dynamodb"
}

resource "aws_vpc_endpoint" "service" {
  vpc_id          = var.vpc_id
  service_name    = data.aws_vpc_endpoint_service.service.service_name
  route_table_ids = [var.route_table_id]
}

resource "aws_vpc_endpoint_route_table_association" "service" {
  route_table_id  = var.route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.service.id
}