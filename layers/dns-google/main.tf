provider "aws" {
}

module "dns" {
  source = "../../modules/dns"
  zone   = var.dns
  name   = var.env
}

module "dns-google" {
  source                = "../../modules/dns-google"
  zone                  = module.dns.zone
  site_verification_ttl = 86400
  site_verification_id  = var.google_site_verification_id
}
