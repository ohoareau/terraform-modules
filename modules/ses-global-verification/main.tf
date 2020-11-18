resource "aws_route53_record" "verification_record" {
  zone_id = var.zone
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [for i in values(var.identities): i.verification_token]
}

resource "aws_ses_domain_mail_from" "domain" {
  domain           = var.domain
  mail_from_domain = "bounce.${var.domain}"
}

resource "aws_route53_record" "mail_from_mx" {
  zone_id = var.zone
  name    = aws_ses_domain_mail_from.domain.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = [for r in [for i in values(var.identities): i.region]: "10 feedback-smtp.${r}.amazonses.com"]
}

resource "aws_route53_record" "mail_from_txt" {
  zone_id = var.zone
  name    = aws_ses_domain_mail_from.domain.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}
