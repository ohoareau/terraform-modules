locals {
  variables = {for o in var.operations: "MICROSERVICE_LAMBDA_${replace(upper(lookup(o, "local_name", "")), "-", "_")}_ARN" => lookup(o, "lambda_arn", "")},
}

module "sns-outgoing-topic-policy" {
  source  = "../sns-topic-policy"
  topic   = var.microservice.sns_topics.outgoing.arn
  sources = [for o in var.operations : lookup(o, "lambda_arn", "")]
}

module "sqs-incoming-queue-event-source-mapping" {
  source = "../sqs-to-lambda-event-source-mapping"
  queue = var.microservice.sqs_queues.incoming.arn
  lambda_arn = module.lambda-events.arn
  lambda_role_name = module.lambda-events.role_name
}

data "aws_iam_policy_document" "appsync_api_role" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [for o in var.operations : lookup(o, "lambda_arn", "")]
  }
}

resource "aws_iam_role_policy" "appsync_api_main_policy" {
  name = "appsync_api_${var.microservice.prefix}_main_policy"
  role = var.microservice.apis.main.assume_role
  policy = data.aws_iam_policy_document.appsync_api_role.json
}

resource "aws_iam_role_policy" "appsync_api_public_policy" {
  name = "appsync_api_${var.microservice.prefix}_public_policy"
  role = var.microservice.apis.public.assume_role
  policy = data.aws_iam_policy_document.appsync_api_role.json
}

module "lambda-migrate" {
  source    = "../lambda"
  file      = var.microservice.file
  name      = "${var.microservice.prefix}-migrate"
  handler   = "index.migrate"
  variables = merge(
  {
    DYNAMODB_TABLE_PREFIX           = var.microservice.table_prefix,
    MICROSERVICE_OUTGOING_TOPIC_ARN = var.microservice.sns_topics.outgoing.arn,
  },
  local.variables,
  var.microservice.variables
  )
  policy_statements = [
    {
      actions   = ["SNS:Publish"]
      resources = [var.microservice.sns_topics.outgoing.arn]
      effect    = "Allow"
    },
    {
      effect    = "Allow"
      actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query", "dynamodb:DeleteItem", "dynamodb:PutItem", "dynamodb:UpdateItem"]
      resources = [
        var.microservice.dynamodb_tables.migration.arn,
        "${var.microservice.dynamodb_tables.migration.arn}/index/*",
      ]
    },
    {
      effect    = "Allow"
      actions   = ["lambda:InvokeFunction"]
      resources = [for o in var.operations : lookup(o, "lambda_arn", "")]
    },
  ]
}
module "lambda-events" {
  source    = "../lambda"
  file      = var.microservice.file
  name      = "${var.microservice.prefix}-events"
  handler   = "index.receiveExternalEvents"
  variables = merge(
  {
    DYNAMODB_TABLE_PREFIX           = var.microservice.table_prefix,
    MICROSERVICE_OUTGOING_TOPIC_ARN = var.microservice.sns_topics.outgoing.arn
  },
  local.variables,
  var.microservice.variables
  )
  policy_statements = [
    {
      actions   = ["SNS:Publish"]
      resources = [var.microservice.sns_topics.outgoing.arn]
      effect    = "Allow"
    },
    {
      effect    = "Allow"
      actions   = ["lambda:InvokeFunction"]
      resources = [for o in var.operations : lookup(o, "lambda_arn", "")]
    },
  ]
}