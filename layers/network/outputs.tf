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
  value = aws_route_table.private
}