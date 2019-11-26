locals {
  prefix       = "${var.env}-${var.name}"
  table_prefix = "${var.env}_${var.name}_"
  variables    = var.debug ? {MICROSERVICE_DEBUG = "true"} : {}
}

data "aws_iam_policy_document" "appsync_api_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["appsync.amazonaws.com"]
      type = "Service"
    }
    effect = "Allow"
  }
}
data "aws_iam_policy_document" "appsync_api_public_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["appsync.amazonaws.com"]
      type = "Service"
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "appsync_api" {
  name = "appsync_api_${var.api_name}_${local.prefix}"
  assume_role_policy = data.aws_iam_policy_document.appsync_api_assume_role.json
}
resource "aws_iam_role" "appsync_api_public" {
  name = "appsync_api_public_${var.api_name}_${local.prefix}"
  assume_role_policy = data.aws_iam_policy_document.appsync_api_public_assume_role.json
}

module "sns-outgoing-topic" {
  source = "../sns-topic"
  name = "${local.prefix}-outgoing"
}

module "sqs-incoming-queue" {
  source = "../sqs-to-lambda"
  name = "${local.prefix}-incoming"
}

module "dynamodb-table-migration" {
  source = "../dynamodb-table"
  name = "${local.table_prefix}migration"
  attributes = {id = {type = "S"}}
  indexes    = {}
}

module "lambda-migrate" {
  source    = "../lambda"
  file      = var.file
  name      = "${local.prefix}-migrate"
  handler   = "index.migrate"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX           = local.table_prefix,
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    local.variables
  )
  policy_statements = [
    {
      actions   = ["SNS:Publish"]
      resources = [module.sns-outgoing-topic.arn]
      effect    = "Allow"
    },
    {
      effect    = "Allow"
      actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query", "dynamodb:DeleteItem", "dynamodb:PutItem", "dynamodb:UpdateItem"]
      resources = [
        module.dynamodb-table-migration.arn,
        "${module.dynamodb-table-migration.arn}/index/*",
      ]
    }
  ]
}
module "lambda-events" {
  source    = "../lambda"
  file      = var.file
  name      = "${local.prefix}-events"
  handler   = "index.receiveExternalEvents"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX           = local.table_prefix,
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn
    },
    local.variables
  )
  policy_statements = [
    {
      actions   = ["SNS:Publish"]
      resources = [module.sns-outgoing-topic.arn]
      effect    = "Allow"
    }
  ]
}
