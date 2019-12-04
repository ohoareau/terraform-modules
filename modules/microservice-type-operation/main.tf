locals {
  name        = "${var.type.prefix}-${var.family}${local.name_suffix}"
  name_suffix = ("" != var.name) ? "-${var.name}" : ""
  local_name = "${var.type.full_name}-${var.family}${local.name_suffix}"
  tags       = merge(var.tags, {
    MicroserviceOperation = local.name
    MicroserviceOperationFamily = var.family
  })
}

module "operation" {
  source       = "../microservice-operation"
  enabled      = var.enabled
  microservice = var.type.microservice
  name         = local.name
  handler      = var.handler
  resolvers    = var.resolvers
  timeout      = var.timeout
  memory_size  = var.memory_size
  tags         = local.tags
  variables    = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.type.microservice.table_prefix,
    },
    var.variables,
  )
  policy_statements = var.policy_statements
}