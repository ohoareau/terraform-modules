locals {
  definition_file = ("" == var.definition_file) ? "${path.module}/files/default.json.tmpl" : var.definition_file
  definition_vars = merge(
    var.definition_vars,
    {}
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
  definition        = definition
  policy_statements = local.policy_statements
}