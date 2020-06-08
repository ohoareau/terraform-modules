resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = var.protocol
  description   = var.name
  target        = var.lambda_arn
}