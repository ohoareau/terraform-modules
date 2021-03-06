module "appsync-datasource-lambda" {
  source     = "../appsync-datasource-lambda"
  api        = var.api
  api_name   = var.api_name
  name       = var.name
  lambda_arn = var.lambda_arn
}

resource "aws_appsync_resolver" "query" {
  api_id            = var.api
  field             = var.name
  type              = var.type
  data_source       = module.appsync-datasource-lambda.name
  request_template  = templatefile("${path.module}/request.vm.tpl", {sourcePrefix: ("Query" == var.type) ? "" : "${lower(substr(var.type, 0, 1))}${substr(var.type, 1, length(var.type) - 1)}_"})
  response_template = templatefile("${path.module}/response.vm.tpl", {})
}