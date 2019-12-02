locals {
  statements = concat(
    var.statements,
    (0 != length(var.actions)) ? [{actions: var.actions, resources: var.resources}] : []
  )
}

data "aws_iam_policy_document" "lambda" {
  dynamic "statement" {
    iterator = s
    for_each = local.statements
    content {
      actions   = lookup(s.value, "actions", [])
      resources = lookup(s.value, "resources", [])
      effect    = lookup(s.value, "effect", "Allow")
    }
  }
}

resource "aws_iam_role_policy" "lambda" {
  count  = var.enabled ? 1 : 0
  name   = "lambda-${var.name}-policy-${var.policy_name}"
  policy = data.aws_iam_policy_document.lambda.json
  role   = var.role_name
}