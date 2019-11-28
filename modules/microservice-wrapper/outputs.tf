output "lambdas" {
  value = {
    events = {
      arn = module.operation-events.lambda_arn
      role_name = module.operation-events.lambda_role_name
      role_arn = module.operation-events.lambda_role_arn
    }
    migrate = {
      arn = module.operation-migrate.lambda_arn
      role_name = module.operation-migrate.lambda_role_name
      role_arn = module.operation-migrate.lambda_role_arn
    }
  }
}