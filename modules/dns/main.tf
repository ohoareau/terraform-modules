resource "aws_route53_delegation_set" "primary" {
  reference_name = "primary"
}
resource "aws_route53_zone" "zone" {
  name              = "${var.zone}."
  delegation_set_id = aws_route53_delegation_set.primary.id
  comment           = "${var.name} zone"
}

locals {
  statics = (null != var.statics_file) ? csvdecode(trim(file(var.statics_file))) : []
  entries = {for entry in local.statics : "${entry.type}-${entry.name}" => entry}
}

resource "aws_route53_record" "statics" {
  for_each = {for record_name, record in local.entries: record_name => record if ((record.env == null) || (record.env == var.env))}
  zone_id = var.zone
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = split("\n", each.value.value)
}