module "operation" {
  source            = "../microservice-type-operation"
  enabled           = var.enabled
  type              = var.type
  resolver          = var.resolver
  public_resolver   = var.public_resolver
  family            = "events"
  handler_name      = "index.receive${var.type.full_upper_name}ExternalEvents"
  resolver_mode     = "mutation"
  variables         = var.variables
  policy_statements = var.policy_statements
}