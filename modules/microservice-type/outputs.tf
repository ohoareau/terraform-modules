output "prefix" {
  value = local.prefix
}
output "name" {
  value = var.name
}
output "table_prefix" {
  value = local.table_prefix
}
output "name_plural" {
  value = local.name_plural
}
output "full_name_plural" {
  value = local.full_name_plural
}
output "upper_name" {
  value = local.upper_name
}
output "full_name" {
  value = local.full_name
}
output "full_upper_name" {
  value = local.full_upper_name
}
output "upper_name_plural" {
  value = local.upper_name_plural
}
output "full_upper_name_plural" {
  value = local.full_upper_name_plural
}
output "dynamodb-table" {
  value = module.dynamodb-table
}
output "microservice" {
  value = var.microservice
}