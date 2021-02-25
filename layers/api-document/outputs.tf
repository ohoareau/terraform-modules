output "endpoint" {
  value = module.api-lambda.endpoint
}
output "internal_endpoint" {
  value = module.api-lambda.internal_endpoint
}
output "lambda_arn" {
  value = module.lambda.arn
}
output "lambda_invoke_arn" {
  value = module.lambda.invoke_arn
}
output "lambda_name" {
  value = module.lambda.name
}
output "lambda_role_name" {
  value = module.lambda.role_name
}