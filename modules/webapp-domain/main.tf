provider "aws" {
}
provider "aws" {
  alias = "acm"
}

module "custom-domaine" {
  source = "../apigateway2-api-domain"
  api    = var.gateway_id
  stage  = var.gateway_stage
  dns    = var.dns
  zone   = var.zone
  providers = {
    aws     = aws
    aws.acm = aws.acm
  }
}