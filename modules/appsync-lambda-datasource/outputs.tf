output "name" {
  value = var.enabled ? aws_appsync_datasource.lambda[0].name : null
}