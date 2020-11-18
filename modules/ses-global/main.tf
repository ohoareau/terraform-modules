resource "aws_ses_domain_dkim" "dkim" {
  domain = var.domain
}

resource "aws_route53_record" "dkim_record" {
  count   = 3
  zone_id = var.zone
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
