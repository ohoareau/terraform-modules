output "name" {
  value = var.name
}
output "arn" {
  value = var.enabled ? aws_lambda_function.lambda[0].arn : null
}
output "role_arn" {
  value = var.enabled ? aws_iam_role.lambda[0].arn : null
}
output "role_name" {
  value = var.enabled ? aws_iam_role.lambda[0].name : null
}