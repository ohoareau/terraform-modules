provider "aws" {
}

module "lambda" {
  source                = "../lambda-api-base"
  name                  = var.name
  runtime               = var.runtime
  timeout               = var.timeout
  memory_size           = var.memory_size
  handler               = var.handler
  variables             = var.variables
  publish               = var.publish
  policy_statements     = var.policy_statements
  config_file           = var.config_file
  config_statics_file   = var.config_statics_file
  utils_file            = var.utils_file
  root_file             = var.root_file
  site_webmanifest_file = var.site_webmanifest_file
  healthz_file          = var.healthz_file
  robots_file           = var.robots_file
  sitemap_file          = var.sitemap_file
  package_file          = "${path.module}/lambda-code.zip"
  code_dir              = "${path.module}/code"
  providers             = {
    aws = aws
  }
}