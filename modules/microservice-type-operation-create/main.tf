module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  family            = "create"
  handler           = ("" != var.handler) ? var.handler : "index.create${var.type.full_upper_name}"
  resolvers         = var.resolvers
  variables         = var.variables
  timeout           = var.timeout
  memory_size       = var.memory_size
  tags              = var.tags
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