output "id" {
  value = aws_cognito_user_pool.pool.id
}
output "arn" {
  value = aws_cognito_user_pool.pool.arn
}
output "email_identity" {
  value = ("" != var.email_identity) ? var.email_identity : null
}
output "sns_outgoing_topic_arn" {
  value = var.post_triggers ? module.sns-outgoing-topic.arn : null
}