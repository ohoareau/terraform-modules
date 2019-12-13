module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  family            = "list"
  handler           = ("" != var.handler) ? var.handler : "index.get${var.type.full_upper_name_plural}"
  resolvers         = var.resolvers
  variables         = var.variables
  timeout           = var.timeout
  memory_size       = var.memory_size
  tags              = var.tags
  required_external_operations = var.required_external_operations
  policy_statements = concat(
    var.policy_statements,
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query"]
        resources = [var.type.dynamodb-table.arn, "${var.type.dynamodb-table.arn}/index/*"]
        effect    = "Allow"
      },
    ]
  )
}