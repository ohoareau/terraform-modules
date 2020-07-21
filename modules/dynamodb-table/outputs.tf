output "arn" {
  value = (var.enabled && (length(aws_dynamodb_table.table) > 0)) ? aws_dynamodb_table.table[0].arn : null
}
output "name" {
  value = (var.enabled && (length(aws_dynamodb_table.table) > 0)) ? aws_dynamodb_table.table[0].name : null
}
output "stream_arn" {
  value = (var.enabled && (length(aws_dynamodb_table.table) > 0) && aws_dynamodb_table.table[0].stream_enabled) ? aws_dynamodb_table.table[0].stream_arn : null
}
output "stream_label" {
  value = (var.enabled && (length(aws_dynamodb_table.table) > 0) && aws_dynamodb_table.table[0].stream_enabled) ? aws_dynamodb_table.table[0].stream_label : null
}