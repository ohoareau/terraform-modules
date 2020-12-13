provider "aws" {
}

provider "aws" {
  alias = "acm"
}

module "website" {
  source      = "../../modules/website"
  name        = var.name
  bucket_name = var.bucket_name
  zone        = var.dns_zone
  dns         = var.dns
  providers   = {
    aws = aws
    aws.acm = aws.acm
  }
}
