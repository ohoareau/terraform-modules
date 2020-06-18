resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = var.protocol
  description   = var.name
  target        = var.lambda_arn

  cors_configuration {
    allow_credentials = var.cors.allow_credentials
    allow_headers     = var.cors.allow_headers
    allow_methods     = var.cors.allow_methods
    allow_origins     = var.cors.allow_origins
    expose_headers    = var.cors.expose_headers
    max_age           = var.cors.max_age
  }
}
resource "aws_lambda_permission" "apigw_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
