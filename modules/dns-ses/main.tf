resource "aws_route53_record" "validation" {
  zone_id = var.zone
  name    = "_amazonses"
  type    = "TXT"

  records = [
    var.verification_id,
  ]

  ttl = var.ttl
  count = var.verification_id != "" ? 1 : 0
}
resource "aws_route53_record" "dkim-01" {
  zone_id = var.zone
  name    = "${var.dkim_verification_id_01}._domainkey"
  type    = "CNAME"

  records = [
    "${var.dkim_verification_id_01}.dkim.amazonses.com",
  ]

  ttl = var.dkim_ttl
  count = var.dkim_verification_id_01 != "" ? 1 : 0
}
resource "aws_route53_record" "dkim-02" {
  zone_id = var.zone
  name    = "${var.dkim_verification_id_02}._domainkey"
  type    = "CNAME"

  records = [
    "${var.dkim_verification_id_02}.dkim.amazonses.com",
  ]

  ttl = var.dkim_ttl
  count = var.dkim_verification_id_02 != "" ? 1 : 0
}
resource "aws_route53_record" "dkim-03" {
  zone_id = var.zone
  name    = "${var.dkim_verification_id_03}._domainkey"
  type    = "CNAME"

  records = [
    "${var.dkim_verification_id_03}.dkim.amazonses.com",
  ]

  ttl = var.dkim_ttl
  count = var.dkim_verification_id_03 != "" ? 1 : 0
}
