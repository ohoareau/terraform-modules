provider "aws" {
}

module "dns" {
  source = "../../modules/dns2"
  zone   = var.dns
  name   = var.env
}
