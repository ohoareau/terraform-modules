module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  family            = "events"
  handler           = "index.receive${var.type.full_upper_name}ExternalEvents"
  resolvers         = var.resolvers
  variables         = var.variables
  policy_statements = var.policy_statements
}