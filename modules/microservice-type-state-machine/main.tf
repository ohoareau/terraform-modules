locals {
  definition_file = ("" == var.definition_file) ? "${path.module}/files/default.json.tmpl" : var.definition_file
  definition_vars = merge(
    var.definition_vars,
    {
      CLUSTER = var.type.microservice.tasks_cluster
      SECURITY_GROUPS = var.type.microservice.tasks_vpc_security_groups
      SUBNETS = var.type.microservice.tasks_vpc_subnets
      TASK_PREFIX = var.type.microservice.prefix
    }
  )
  definition        = templatefile(local.definition_file, local.definition_vars)
  policy_statements = concat(
    var.policy_statements,
    [{actions = ["*"], resources = ["*"], effect = "Allow"}]
  )
}
module "state-machine" {
  enabled           = var.enabled
  source            = "../state-machine"
  name              = "${var.type.prefix}-${var.name}"
  definition        = local.definition
  policy_statements = local.policy_statements
}