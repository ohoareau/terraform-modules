output "arn" {
  value = var.enabled ? aws_sns_topic.topic[0].arn : null
}
output "id" {
  value = var.enabled ? aws_sns_topic.topic[0].id : null
}