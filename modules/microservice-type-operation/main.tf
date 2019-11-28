locals {
  name_suffix = ("" != var.name) ? "-${var.name}" : ""
  datasources = {
    main   = "${var.type.prefix}-${var.family}${local.name_suffix}",
    public = "${var.type.prefix}-${var.family}${local.name_suffix}-public",
  }
  local_name = "${var.type.full_name}-${var.family}${local.name_suffix}"
}

module "operation" {
  source       = "../microservice-operation"
  enabled      = var.enabled
  microservice = var.type.microservice
  name         = "${var.type.prefix}-${var.family}${local.name_suffix}"
  handler      = var.handler
  resolvers    = var.resolvers
  variables    = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.type.microservice.table_prefix,
    },
    var.variables,
  )
  policy_statements = var.policy_statements
}