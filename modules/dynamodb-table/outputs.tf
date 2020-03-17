output "arn" {
  value = (var.enabled && (length(aws_dynamodb_table.table) > 0)) ? aws_dynamodb_table.table[0].arn : null
}
output "name" {
  value = (var.enabled && (length(aws_dynamodb_table.table) > 0)) ? aws_dynamodb_table.table[0].name : null
}