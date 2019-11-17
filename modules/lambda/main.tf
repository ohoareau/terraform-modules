resource "aws_lambda_function" "lambda" {
  count            = var.enabled ? 1 : 0
  filename         = var.file
  source_code_hash = filebase64sha256(var.file)
  function_name    = var.name
  role             = aws_iam_role.lambda[0].arn
  handler          = var.handler
  runtime          = var.runtime
  depends_on       = ["module.lambda-policy", "aws_cloudwatch_log_group.lambda[0]"]
  dynamic "environment" {
    iterator = v
    for_each = (0 != length(keys(var.variables))) ? {variables: var.variables} : {}
    content {
        variables = v.value
    }
  }
}

data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  count              = var.enabled ? 1 : 0
  name               = "lambda-${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

resource "aws_cloudwatch_log_group" "lambda" {
  count             = var.enabled ? 1 : 0
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 14
}

module "lambda-policy" {
  source = "../lambda-policy"
  enabled = var.enabled
  name = var.name
  policy_name = "lambda-${var.name}"
  role_name = aws_iam_role.lambda[0].name
  statements = concat(
    [
      {
        actions = ["logs:CreateLogStream", "logs:PutLogEvents"],
        resources = ["arn:aws:logs:*:*:*"],
      },
    ],
    var.policy_statements
  )
}