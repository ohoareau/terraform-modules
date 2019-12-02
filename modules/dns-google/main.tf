resource "aws_route53_record" "mx" {
  count   = var.mx_verification_id != "" ? 0 : 1
  zone_id = var.zone
  name    = ""
  type    = "MX"
  ttl     = var.mx_ttl
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
  ]
}
resource "aws_route53_record" "mx-with-verification" {
  count   = var.mx_verification_id != "" ? 1 : 0
  zone_id = var.zone
  name    = ""
  type    = "MX"
  ttl     = var.mx_ttl
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
    "15 ${var.mx_verification_id}.mx-verification.google.com.",
  ]
}
resource "aws_route53_record" "dkim" {
  count   = var.dkim_verification_id != "" ? 1 : 0
  zone_id = var.zone
  name    = "google._domainkey"
  type    = "TXT"
  ttl     = var.dkim_ttl
  records = [var.dkim_verification_id]
}
resource "aws_route53_record" "site-verification" {
  count   = var.site_verification_id != "" ? 1 : 0
  zone_id = var.zone
  name    = ""
  type    = "TXT"
  ttl     = var.site_verification_ttl
  records = ["google-site-verification=${var.site_verification_id}"]
}