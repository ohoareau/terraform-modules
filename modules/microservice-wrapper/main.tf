locals {
  lambda_arns = concat(
    [for o in var.operations : lookup(o, "lambda_arn", "")],
    [module.operation-migrate.lambda_arn, module.operation-events.lambda_arn]
  )
}

module "sns-outgoing-topic-policy" {
  source  = "../sns-topic-policy"
  topic   = var.microservice.sns_topics.outgoing.arn
  sources = local.lambda_arns
}

module "sqs-incoming-queue-event-source-mapping" {
  source           = "../sqs-to-lambda-event-source-mapping"
  queue            = var.microservice.sqs_queues.incoming.arn
  lambda_arn       = module.operation-events.lambda_arn
  lambda_role_name = module.operation-events.lambda_role_name
}

data "aws_iam_policy_document" "appsync_api_role" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = local.lambda_arns
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

module "operation-migrate" {
  source            = "../microservice-operation"
  microservice      = var.microservice
  name              = "${var.microservice.prefix}-migrate"
  handler           = "index.migrate"
  variables         = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.microservice.table_prefix,
    },
    var.migrate_variables,
  )
  policy_statements = concat(
    var.migrate_policy_statements,
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query"]
        resources = [
          var.microservice.dynamodb_tables.migration.arn,
          "${var.microservice.dynamodb_tables.migration.arn}/index/*",
        ]
        effect    = "Allow"
      },
    ]
  )
}
module "operation-events" {
  source            = "../microservice-operation"
  microservice      = var.microservice
  name              = "${var.microservice.prefix}-events"
  handler           = "index.receiveExternalEvents"
  variables         = var.events_variables
  policy_statements = var.events_policy_statements
}