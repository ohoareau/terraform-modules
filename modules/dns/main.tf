resource "aws_route53_delegation_set" "primary" {
  reference_name = "primary"
}
resource "aws_route53_zone" "zone" {
  name              = "${var.zone}."
  delegation_set_id = aws_route53_delegation_set.primary.id
  comment           = "${var.name} zone"
}
