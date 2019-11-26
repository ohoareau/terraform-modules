module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  resolver          = var.resolver
  public_resolver   = var.public_resolver
  family            = "get"
  handler_name      = "index.get${var.type.full_upper_name}"
  resolver_mode     = "query"
  variables         = var.variables
  policy_statements = concat(
    var.policy_statements,
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable"]
        resources = [var.type.dynamodb-table.arn, "${var.type.dynamodb-table.arn}/index/*"]
        effect    = "Allow"
      },
    ]
  )
}