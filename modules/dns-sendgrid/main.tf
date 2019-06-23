resource "aws_route53_record" "01" {
  zone_id = var.zone
  name    = var.id_01
  type    = "CNAME"

  records = [
    "sendgrid.net",
  ]

  ttl = var.ttl
  count = var.id_01 != "" ? 1 : 0
}

resource "aws_route53_record" "02" {
  zone_id = var.zone
  name    = var.id_02
  type    = "CNAME"

  records = [
    "sendgrid.net",
  ]

  ttl = var.ttl
  count = var.id_02 != "" ? 1 : 0
}

resource "aws_route53_record" "03" {
  zone_id = var.zone
  name    = var.id_03
  type    = "CNAME"

  records = [
    "${var.value_03}.wl232.sendgrid.net",
  ]

  ttl = var.ttl
  count = var.id_03 != "" ? 1 : 0
}

resource "aws_route53_record" "dkim-01" {
  zone_id = var.zone
  name    = "s1._domainkey"
  type    = "CNAME"

  records = [
    "s1.domainkey.${var.dkim_verification_id_01}.wl232.sendgrid.net",
  ]

  ttl = var.dkim_ttl
  count = var.dkim_verification_id_01 != "" ? 1 : 0
}

resource "aws_route53_record" "dkim-02" {
  zone_id = var.zone
  name    = "s2._domainkey"
  type    = "CNAME"

  records = [
    "s2.domainkey.${var.dkim_verification_id_02}.wl232.sendgrid.net",
  ]

  ttl = var.dkim_ttl
  count = var.dkim_verification_id_02 != "" ? 1 : 0
}

resource "aws_route53_record" "dedicated-ip-01" {
  zone_id = var.zone
  name    = var.dedicated_ip_01_name
  type    = "A"

  records = [
    var.dedicated_ip_01,
  ]

  ttl = var.dedicated_ip_ttl
  count = var.dedicated_ip_01 != "" ? 1 : 0
}
