resource "aws_route53_record" "01" {
  count   = var.id_01 != "" ? 1 : 0
  zone_id = var.zone
  name    = var.id_01
  type    = "CNAME"
  ttl     = var.ttl
  records = [
    "sendgrid.net",
  ]
}
resource "aws_route53_record" "02" {
  count   = var.id_02 != "" ? 1 : 0
  zone_id = var.zone
  name    = var.id_02
  type    = "CNAME"
  ttl     = var.ttl
  records = [
    "sendgrid.net",
  ]
}
resource "aws_route53_record" "03" {
  count   = var.id_03 != "" ? 1 : 0
  zone_id = var.zone
  name    = var.id_03
  type    = "CNAME"
  ttl     = var.ttl
  records = [
    "${var.value_03}.wl232.sendgrid.net",
  ]
}
resource "aws_route53_record" "dkim-01" {
  count   = var.dkim_verification_id_01 != "" ? 1 : 0
  zone_id = var.zone
  name    = "s1._domainkey"
  type    = "CNAME"
  ttl     = var.dkim_ttl
  records = [
    "s1.domainkey.${var.dkim_verification_id_01}.wl232.sendgrid.net",
  ]
}
resource "aws_route53_record" "dkim-02" {
  count   = var.dkim_verification_id_02 != "" ? 1 : 0
  zone_id = var.zone
  name    = "s2._domainkey"
  type    = "CNAME"
  ttl     = var.dkim_ttl
  records = [
    "s2.domainkey.${var.dkim_verification_id_02}.wl232.sendgrid.net",
  ]
}
resource "aws_route53_record" "dedicated-ip-01" {
  count   = var.dedicated_ip_01 != "" ? 1 : 0
  zone_id = var.zone
  name    = var.dedicated_ip_01_name
  type    = "A"
  ttl     = var.dedicated_ip_ttl
  records = [
    var.dedicated_ip_01,
  ]
}