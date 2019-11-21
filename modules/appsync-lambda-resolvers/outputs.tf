output "api_assume_role_arn" {
  value = var.enabled ? aws_iam_role.appsync_api[0].arn : null
}