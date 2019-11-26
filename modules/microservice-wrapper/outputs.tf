output "lambdas" {
  value = {
    events = {
      arn = module.lambda-events.arn
      role_name = module.lambda-events.role_name
      role_arn = module.lambda-events.role_arn
    }
    migrate = {
      arn = module.lambda-migrate.arn
      role_name = module.lambda-migrate.role_name
      role_arn = module.lambda-migrate.role_arn
    }
  }
}