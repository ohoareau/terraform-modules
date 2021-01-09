output "arn" {
  value = aws_vpc_endpoint.service.arn
}
output "id" {
  value = aws_vpc_endpoint.service.id
}
output "service_name" {
  value = data.aws_vpc_endpoint_service.service.service_name
}