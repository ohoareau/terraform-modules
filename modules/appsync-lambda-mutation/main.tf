module "appsync-datasource-lambda" {
  source = "../appsync-datasource-lambda"
  api = var.api
  api_name = var.api_name
  name = var.name
  lambda_arn = var.lambda_arn
}
resource "aws_appsync_resolver" "create" {
  api_id            = var.api
  field             = var.name
  type              = "Mutation"
  data_source       = module.appsync-datasource-lambda.name
  request_template  = file("${path.module}/files/request.vm")
  response_template = file("${path.module}/files/response.vm")
}