provider "aws" {
}

locals {
  identities = {
    main   = module.ses-regional-identity
  }
}

module "ses-global" {
  source          = "../../modules/ses-global"
  domain          = var.dns
  zone            = var.zone
}

module "ses-regional-identity" {
  source          = "../../modules/ses-regional-identity"
  name            = "${var.env}-${replace(var.dns, ".", "-")}"
  sources         = var.sources
  service_sources = var.service_sources
  domain          = var.dns
  zone            = var.zone
  emails          = var.identities
  providers = {
    aws = aws
  }
}
module "ses-global-verification" {
  source          = "../../modules/ses-global-verification"
  domain          = var.dns
  zone            = var.zone
  identities      = local.identities
  providers = {
    aws = aws
  }
}

module "ses-regional-verification" {
  source    = "../../modules/ses-regional-verification"
  id        = module.ses-regional-identity.id
  providers = {
    aws = aws
  }
  depends_on = [module.ses-global-verification]
}
