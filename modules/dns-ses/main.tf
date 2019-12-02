resource "aws_route53_record" "validation" {
  count   = var.verification_id != "" ? 1 : 0
  zone_id = var.zone
  name    = "_amazonses"
  type    = "TXT"
  ttl     = var.ttl
  records = [
    var.verification_id,
  ]
}
resource "aws_route53_record" "dkim-01" {
  count   = var.dkim_verification_id_01 != "" ? 1 : 0
  zone_id = var.zone
  name    = "${var.dkim_verification_id_01}._domainkey"
  type    = "CNAME"
  ttl     = var.dkim_ttl
  records = [
    "${var.dkim_verification_id_01}.dkim.amazonses.com",
  ]
}
resource "aws_route53_record" "dkim-02" {
  count   = var.dkim_verification_id_02 != "" ? 1 : 0
  zone_id = var.zone
  name    = "${var.dkim_verification_id_02}._domainkey"
  type    = "CNAME"
  ttl     = var.dkim_ttl
  records = [
    "${var.dkim_verification_id_02}.dkim.amazonses.com",
  ]
}
resource "aws_route53_record" "dkim-03" {
  count   = var.dkim_verification_id_03 != "" ? 1 : 0
  zone_id = var.zone
  name    = "${var.dkim_verification_id_03}._domainkey"
  type    = "CNAME"
  ttl     = var.dkim_ttl
  records = [
    "${var.dkim_verification_id_03}.dkim.amazonses.com",
  ]
}