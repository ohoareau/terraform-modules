output "zone" {
  value = aws_route53_zone.zone.id
}
output "ns" {
  value = var.zone
}
