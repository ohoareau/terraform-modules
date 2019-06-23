resource "aws_route53_record" "mx" {
  zone_id = var.zone
  name    = ""
  type    = "MX"

  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
  ]

  ttl = var.mx_ttl
  count = var.mx_verification_id != "" ? 0 : 1
}
resource "aws_route53_record" "mx-with-verification" {
  zone_id = var.zone
  name    = ""
  type    = "MX"

  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
    "15 ${var.mx_verification_id}.mx-verification.google.com.",
  ]

  ttl = var.mx_ttl
  count = var.mx_verification_id != "" ? 1 : 0
}
resource "aws_route53_record" "dkim" {
  zone_id = var.zone
  name    = "google._domainkey"
  type    = "TXT"

  records = [var.dkim_verification_id]

  ttl = var.dkim_ttl
  count = var.dkim_verification_id != "" ? 1 : 0
}
resource "aws_route53_record" "site-verification" {
  zone_id = var.zone
  name    = ""
  type    = "TXT"

  records = ["google-site-verification=${var.site_verification_id}"]

  ttl = var.site_verification_ttl
  count = var.site_verification_id != "" ? 1 : 0
}
