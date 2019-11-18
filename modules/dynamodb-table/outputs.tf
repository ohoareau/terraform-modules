output "arn" {
  value = var.enabled ? aws_dynamodb_table.table[0].arn : null
}

output "name" {
  value = var.enabled ? aws_dynamodb_table.table[0].name : null
}