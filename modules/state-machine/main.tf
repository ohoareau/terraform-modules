resource "aws_sfn_state_machine" "sfn" {
  name     = var.name
  role_arn = aws_iam_role.sfn-exec.arn
  definition = var.definition
}

data "aws_iam_policy_document" "sfn-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "sfn-exec" {
  dynamic "statement" {
    iterator = s
    for_each = var.policy_statements
    content {
      actions = lookup(s.value, "actions", [])
      resources = lookup(s.value, "resources", [])
      effect = lookup(s.value, "effect", "Allow")
    }
  }
}
resource "aws_iam_role" "sfn-exec" {
  name = "${var.name}-sfn-exec"
  assume_role_policy = data.aws_iam_policy_document.sfn-assume-role.json
}

resource "aws_iam_role_policy" "sfn-exec" {
  role = aws_iam_role.sfn-exec.id
  policy = data.aws_iam_policy_document.sfn-exec.json
}