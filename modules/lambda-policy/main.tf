resource "aws_iam_policy" "lambda-policy" {
  name = "lambda-${var.name}-policy-${var.policy_name}"
  path = "/"
  description = "IAM policy for lambda-${var.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ${jsonencode(var.actions)},
      "Resource": ${jsonencode(var.resources)},
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda-policy-attachment" {
  role = var.role_name
  policy_arn = aws_iam_policy.lambda-policy.arn
}
