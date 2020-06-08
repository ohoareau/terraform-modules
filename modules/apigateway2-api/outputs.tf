output "endpoint" {
  value = aws_apigatewayv2_api.api.api_endpoint
}
output "dns" {
  value = replace(aws_apigatewayv2_api.api.api_endpoint, "/^https?://([^/]*).*/", "$1")
}
output "id" {
  value = aws_apigatewayv2_api.api.id
}
output "stage" {
  value = "$default"
}