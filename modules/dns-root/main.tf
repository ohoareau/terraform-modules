resource "aws_route53_record" "spf" {
  zone_id = var.zone
  name    = ""
  type    = "SPF"

  records = [
    "v=spf1 include:_spf.google.com include:amazonses.com ~all",
    "spf2.0/pra include:_spf.google.com include:amazonses.com ~all",
  ]

  ttl = var.spf_ttl
}
