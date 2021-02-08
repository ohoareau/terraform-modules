module "api" {
  source        = "../../modules/apigateway2-api"
  name          = "${var.env}-api-image"
  lambda_arn    = module.lambda.arn
}

module "api-custom-domain" {
  source = "../../modules/apigateway2-api-domain"
  api    = module.api.id
  stage  = module.api.stage
  dns    = var.dns
  zone   = var.dns_zone
  providers = {
    aws = aws
    aws.acm = aws.acm
  }
}

module "lambda" {
  source            = "../../modules/lambda-api-image"
  name              = "${var.env}-api-image"
  config_file       = var.config_file
  runtime           = var.runtime
  handler           = var.handler
  timeout           = var.timeout
  memory_size       = var.memory_size
  variables         = var.variables
  policy_statements = var.policy_statements
  providers = {
    aws = aws
  }
}