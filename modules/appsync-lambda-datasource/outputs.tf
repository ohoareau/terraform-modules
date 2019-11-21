output "name" {
  value = length(aws_appsync_datasource.lambda) > 0 ? aws_appsync_datasource.lambda[0].name : null
}