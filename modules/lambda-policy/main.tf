locals {
  statements = merge(
    var.statements,
    (0 != length(var.actions)) ? [{actions: var.actions, resources: var.resources}] : []
  )
}
data "aws_iam_policy_document" "lambda" {
  dynamic "statement" {
    iterator = s
    for_each = local.statements
    content {
      actions = lookup(s.value, "actions", [])
      resources = lookup(s.value, "resources", [])
      effect = lookup(s.value, "effect", "Allow")
    }
  }
}
resource "aws_iam_policy" "lambda" {
  count       = var.enabled ? 1 : 0
  name        = "lambda-${var.name}-policy-${var.policy_name}"
  path        = "/"
  description = "IAM policy for lambda-${var.name}"
  policy      = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role_policy_attachment" "lambda" {
  count      = var.enabled ? 1 : 0
  role       = var.role_name
  policy_arn = aws_iam_policy.lambda[0].arn
}
