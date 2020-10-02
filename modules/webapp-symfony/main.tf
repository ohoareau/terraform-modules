module "lambda" {
  source            = "../lambda"
  name              = var.name
  file              = var.package_file
  runtime           = var.runtime
  timeout           = var.timeout
  memory_size       = var.memory_size
  handler           = var.handler
  variables         = var.variables
  enabled           = var.enabled
  policy_statements = var.policy_statements
  tags              = var.tags
  layers            = var.layers
}

module "apigw" {
  source     = "../apigateway2-api"
  name       = var.name
  lambda_arn = module.lambda.arn
  cors       = true
}