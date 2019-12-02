output "name" {
  value = var.enabled ? var.name : null
}
output "arn" {
  value = (var.enabled && 0 < length(aws_lambda_function.lambda)) ? aws_lambda_function.lambda[0].arn : null
}
output "role_arn" {
  value = (var.enabled && 0 < length(aws_lambda_function.lambda)) ? aws_iam_role.lambda[0].arn : null
}
output "role_name" {
  value = (var.enabled && 0 < length(aws_lambda_function.lambda)) ? aws_iam_role.lambda[0].name : null
}