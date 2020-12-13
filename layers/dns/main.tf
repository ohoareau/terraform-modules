provider "aws" {
}

module "dns" {
  source = "../../modules/dns"
  zone   = var.dns
  name   = var.env
}
