output "vpc_name" {
  value = local.name
}
output "vpc_arn" {
  value = aws_vpc.vpc.arn
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnets" {
  value = aws_subnet.private-subnet
}
output "route_tables" {
  value = {
    private = aws_route_table.private
  }
}
output "security_group_id" {
  value = true == var.security_group ? aws_security_group.default[0].id : null
}
output "security_group_name" {
  value = true == var.security_group ? aws_security_group.default[0].name : null
}
output "security_group_arn" {
  value = true == var.security_group ? aws_security_group.default[0].arn : null
}