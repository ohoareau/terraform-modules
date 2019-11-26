module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  resolver          = var.resolver
  public_resolver   = var.public_resolver
  family            = "migrate"
  handler_name      = "index.migrate${var.type.full_upper_name_plural}"
  resolver_mode     = "mutation"
  variables         = merge(
    {
      DYNAMODB_MIGRATION_TABLE_PREFIX = "${var.type.microservice.env}_${var.type.microservice.full_upper_name}_",
    },
    var.variables
  )
  policy_statements = concat(
    var.policy_statements,
    [
      {
        effect    = "Allow"
        actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query", "dynamodb:DeleteItem", "dynamodb:PutItem", "dynamodb:UpdateItem"]
        resources = [
          var.type.microservice.dynamodb-tables.migration.arn,
          "${var.type.microservice.dynamodb-tables.migration.arn}/index/*",
        ]
      }
    ]
  )
}