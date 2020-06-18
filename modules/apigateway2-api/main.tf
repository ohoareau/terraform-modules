resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = var.protocol
  description   = var.name
  target        = var.lambda_arn

  dynamic "cors_configuration" {
    for_each = var.cors ? [var.cors_config] : []
    content {
      allow_credentials = var.cors_config.allow_credentials
      allow_headers     = var.cors_config.allow_headers
      allow_methods     = var.cors_config.allow_methods
      allow_origins     = var.cors_config.allow_origins
      expose_headers    = var.cors_config.expose_headers
      max_age           = var.cors_config.max_age
    }
  }
}
resource "aws_lambda_permission" "apigw_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
