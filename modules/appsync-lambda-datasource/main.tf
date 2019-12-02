resource "aws_appsync_datasource" "lambda" {
  count            = var.enabled ? 1 : 0
  api_id           = var.api
  name             = replace(var.name, "-", "_")
  type             = "AWS_LAMBDA"
  service_role_arn = var.api_assume_role_arn
  lambda_config {
    function_arn = var.lambda_arn
  }
}