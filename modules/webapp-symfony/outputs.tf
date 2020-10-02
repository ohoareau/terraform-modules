output "url" {
  value = module.apigw.endpoint
}
output "dns" {
  value = module.apigw.dns
}
output "gateway_id" {
  value = module.apigw.id
}
output "lambda_arn" {
  value = module.lambda.arn
}
output "lambda_name" {
  value = module.lambda.name
}
output "lambda_role_arn" {
  value = module.lambda.role_arn
}
output "lambda_role_name" {
  value = module.lambda.role_name
}
output "lambda_invoke_arn" {
  value = module.lambda.invoke_arn
}
output "gateway_stage" {
  value = "$default"
}