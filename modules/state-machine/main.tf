resource "aws_sfn_state_machine" "sfn" {
  count      = var.enabled ? 1 : 0
  name       = var.name
  role_arn   = var.enabled ? aws_iam_role.sfn-exec[0].arn : null
  definition = var.definition
}

data "aws_iam_policy_document" "sfn-assume-role" {
  count = var.enabled ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "sfn-exec" {
  count = var.enabled ? 1 : 0
  dynamic "statement" {
    iterator = s
    for_each = var.policy_statements
    content {
      actions   = lookup(s.value, "actions", [])
      resources = lookup(s.value, "resources", [])
      effect    = lookup(s.value, "effect", "Allow")
    }
  }
}
resource "aws_iam_role" "sfn-exec" {
  count              = var.enabled ? 1 : 0
  name               = "${var.name}-sfn-exec"
  assume_role_policy = var.enabled ? data.aws_iam_policy_document.sfn-assume-role[0].json : null
}

resource "aws_iam_role_policy" "sfn-exec" {
  count  = var.enabled ? 1 : 0
  role   = var.enabled ? aws_iam_role.sfn-exec[0].id : null
  policy = var.enabled ? data.aws_iam_policy_document.sfn-exec[0].json : null
}