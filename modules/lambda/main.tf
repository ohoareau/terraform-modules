resource "aws_lambda_function" "lambda" {
  count            = var.enabled ? 1 : 0
  filename         = var.file
  source_code_hash = (null == var.file_hash) ? filebase64sha256(var.file) : var.file_hash
  function_name    = var.name
  role             = aws_iam_role.lambda[0].arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  depends_on       = [module.lambda-policy, aws_cloudwatch_log_group.lambda[0]]
  tags             = var.tags
  layers           = var.layers
  publish          = var.publish

  dynamic "dead_letter_config" {
    iterator = v
    for_each = ("" != var.dlq_sns_topic) ? {dlq: var.dlq_sns_topic} : {}
    content {
      target_arn = v.value
    }
  }
  dynamic "environment" {
    iterator = v
    for_each = (0 != length(keys(var.variables))) ? {variables: var.variables} : {}
    content {
        variables = v.value
    }
  }
  dynamic "vpc_config" {
    iterator = v
    for_each = (0 != length(var.subnet_ids)) ? {x: {subnet_ids: var.subnet_ids, security_group_ids: var.security_group_ids}} : {}
    content {
        subnet_ids         = v.value.subnet_ids
        security_group_ids = v.value.security_group_ids
    }
  }
}

data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = concat(
        ["lambda.amazonaws.com"],
        var.assume_role_identifiers
      )
    }
  }
}

resource "aws_iam_role" "lambda" {
  count              = var.enabled ? 1 : 0
  name               = (64 < length("lambda-${var.name}-role")) ? null : "lambda-${var.name}-role"
  name_prefix        = (64 >= length("lambda-${var.name}-role")) ? null : "lambda-role-"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

resource "aws_cloudwatch_log_group" "lambda" {
  count             = var.enabled ? 1 : 0
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 14
}

module "lambda-policy" {
  source      = "../lambda-policy"
  enabled     = var.enabled
  name        = var.name
  policy_name = "lambda-${var.name}"
  role_name   = (var.enabled && 0 < length(aws_iam_role.lambda)) ? aws_iam_role.lambda[0].name : null
  statements  = concat(
    [
      {
        actions   = ["logs:CreateLogStream", "logs:PutLogEvents"],
        resources = ["arn:aws:logs:*:*:*"],
        effect    = "Allow"
      },
    ],
    var.policy_statements,
    ("" != var.dlq_sns_topic) ? [
      {
        actions   = ["SNS:Publish"],
        resources = [var.dlq_sns_topic],
        effect    = "Allow"
      },
    ] : [],
    length(var.subnet_ids) > 0 ? [
      {
        actions   = [
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        resources = ["*"]
        effect    = "Allow"
      }
    ] : []
  )
}