module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  family            = "delete"
  handler           = ("" != var.handler) ? var.handler : "index.delete${var.type.full_upper_name}"
  resolvers         = var.resolvers
  variables         = var.variables
  policy_statements = concat(
    var.policy_statements,
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable", "dynamodb:PutItem"]
        resources = [var.type.dynamodb-table.arn]
        effect    = "Allow"
      },
    ]
  )
}