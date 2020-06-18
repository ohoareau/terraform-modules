resource "aws_apigatewayv2_api" "api" {
  name          = var.name
  protocol_type = var.protocol
  description   = var.name
  target        = var.lambda_arn
  cors_configuration = var.cors_config
}
resource "aws_lambda_permission" "apigw_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
