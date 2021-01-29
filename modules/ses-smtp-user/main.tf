resource "aws_iam_user" "user" {
  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary
}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

data "aws_iam_policy_document" "ses_send_access" {
  statement {
    effect = "Allow"

    actions = [
      "ses:SendRawEmail",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "user" {
  name_prefix = var.user_policy_name_prefix
  user        = aws_iam_user.user.name
  policy      = data.aws_iam_policy_document.ses_send_access.json
}