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
  value = var.enabled ? merge(aws_subnet.public-subnet, aws_subnet.private-subnet) : {}
}
output "public_subnets" {
  value = var.enabled ? aws_subnet.public-subnet : {}
}
output "private_subnets" {
  value = var.enabled ? aws_subnet.private-subnet : {}
}
output "security_groups" {
  value = var.enabled ? aws_security_group.security_group : {}
}
output "private_route_table_ids" {
  value = local.has_private ? {for k,v in aws_route_table.private: k => v.id} : null
}
