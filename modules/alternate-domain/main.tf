module "dns" {
  source = "../dns"
  zone   = var.domain
  name   = "Alternate domain to ${var.target}"
}
module "dns-google" {
  source               = "../dns-google"
  zone                 = module.dns.zone
  site_verification_id = var.domain_google_site_verification_id
}
resource "aws_route53_record" "apex" {
  zone_id = module.dns.zone
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_s3_bucket.alternate.website_domain
    zone_id                = aws_s3_bucket.alternate.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "www" {
  zone_id = module.dns.zone
  name    = "www.${var.domain}"
  type    = "A"
  alias {
    name                   = aws_s3_bucket.alternate-www.website_domain
    zone_id                = aws_s3_bucket.alternate-www.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket" "alternate" {
  bucket = var.domain
  website {
    redirect_all_requests_to = var.target
  }
}

resource "aws_s3_bucket" "alternate-www" {
  bucket = "www.${var.domain}"
  website {
    redirect_all_requests_to = var.target
  }
}