locals {
  name        = "${var.type.prefix}-${var.family}${local.name_suffix}"
  name_suffix = ("" != var.name) ? "-${var.name}" : ""
  local_name = "${var.type.full_name}-${var.family}${local.name_suffix}"
  tags       = merge(var.tags, {
    MicroserviceType            = var.type.full_name
    MicroserviceOperation       = local.name
    MicroserviceOperationFamily = var.family
    MicroserviceTypeOperation   = "${var.family}${local.name_suffix}"
  })
  extra_variables = {for o in var.required_external_operations: var.type.microservice.registered_external_operations[o].variable => var.type.microservice.registered_external_operations[o].arn}
  extra_invokable_lambda_arns = [for o in var.required_external_operations: var.type.microservice.registered_external_operations[o].arn]
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
    local.extra_variables,
    var.variables
  )
  policy_statements = concat(
    var.policy_statements,
    (length(local.extra_invokable_lambda_arns) > 0) ? [{
      effect    = "Allow"
      actions   = ["lambda:InvokeFunction"]
      resources = local.extra_invokable_lambda_arns
    }] : []
  )
}