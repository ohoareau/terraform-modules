module "api-lambda" {
  source               = "../../modules/api-lambda"
  name                 = "event"
  env                  = var.env
  dns                  = var.dns
  forward_query_string = var.forward_query_string
  price_class          = var.price_class
  geolocations         = var.geolocations
  dns_zone             = var.dns_zone
  lambda_arn           = module.lambda.arn
  providers            = {
    aws     = aws
    aws.acm = aws.acm
  }
}

module "lambda" {
  source                = "../../modules/lambda-api-event"
  name                  = "${var.env}-api-event"
  config_file           = var.config_file
  config_statics_file   = var.config_statics_file
  utils_file            = var.utils_file
  sitemap_file          = var.sitemap_file
  robots_file           = var.robots_file
  root_file             = var.root_file
  site_webmanifest_file = var.site_webmanifest_file
  healthz_file          = var.healthz_file
  runtime               = var.runtime
  handler               = var.handler
  timeout               = var.timeout
  memory_size           = var.memory_size
  variables             = var.variables
  publish               = var.publish
  policy_statements     = var.policy_statements
  providers             = {
    aws = aws
  }
}
