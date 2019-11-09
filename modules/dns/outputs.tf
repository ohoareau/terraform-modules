output "zone" {
  value = aws_route53_zone.zone.id
}
output "ns" {
  value = var.zone
}
output "name_servers" {
  value = aws_route53_zone.zone.name_servers
}