provider "aws" {
}

provider "aws" {
  alias = "shared"
}

locals {
  identities = {
    main   = module.ses-regional-identity
    shared = module.ses-regional-identity-shared
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
module "ses-regional-identity-shared" {
  source          = "../../modules/ses-regional-identity"
  name            = "${var.env}-${replace(var.dns, ".", "-")}"
  sources         = var.sources
  service_sources = var.service_sources
  domain          = var.dns
  zone            = var.zone
  emails          = var.identities
  providers = {
    aws = aws.shared
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
module "ses-regional-verification-shared" {
  source    = "../../modules/ses-regional-verification"
  id        = module.ses-regional-identity-shared.id
  providers = {
    aws = aws.shared
  }
  depends_on = [module.ses-global-verification]
}

module "pinpoint-app" {
  source = "../../modules/pinpoint-app"
  name   = "${var.env}-${replace(var.dns, ".", "-")}"
  email  = null != var.pinpoint_channels.email ? {from = "${var.identities[var.pinpoint_channels.email.identity]}@${var.dns}", identity = module.ses-regional-identity-shared.arn} : null
  providers = {
    aws = aws.shared
  }
}