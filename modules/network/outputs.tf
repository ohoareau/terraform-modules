output "arn" {
  value = var.enabled ? aws_vpc.vpc[0].arn : null
}
output "cidr_block" {
  value = var.enabled ? aws_vpc.vpc[0].cidr_block : null
}
output "id" {
  value = var.enabled ? aws_vpc.vpc[0].id : null
}
output "subnets" {
  value = var.enabled ? aws_subnet.subnet : {}
}
output "security_groups" {
  value = var.enabled ? aws_security_group.security_group : {}
}