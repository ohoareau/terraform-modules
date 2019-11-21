output "name" {
  value = var.enabled ? element(aws_appsync_datasource.lambda, 0).name : null
}