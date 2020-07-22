provider "aws" {
}

module "ses" {
  source          = "../../modules/ses"
  name            = "${var.env}-${replace(var.dns, ".", "-")}"
  sources         = var.sources
  service_sources = var.service_sources
  domain          = var.dns
  zone            = var.zone
  emails          = var.identities
}