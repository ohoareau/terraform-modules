data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


locals {
  aws_account   = data.aws_caller_identity.current.account_id
  aws_region    = data.aws_region.current.name
  prefix        = "${var.env}-${var.name}"
  bucket_prefix = "${var.env}-{PREFIX}-${var.name}"
  table_prefix  = "${var.env}_${var.name}_"
  variables     = var.debug ? {MICROSERVICE_DEBUG = "true"} : {}
  registered_external_operations = {for item in flatten(
    [for ms_name, ms in var.required_types:
      [for type_name,type in ms:
        [for op_name,op in type:
          {
            microservice = ms_name
            type = type_name
            operation = op_name
            config = op
          }
        ]
      ]
    ]
  ): "${item.microservice}.${item.type}.${item.operation}" => {
    variable = "MICROSERVICE_${replace(upper(item.microservice), ".", "_")}_${replace(upper(item.type), ".", "_")}_${replace(upper(item.operation), ".", "_")}_LAMBDA_ARN",
    arn      = "arn:aws:lambda:${local.aws_region}:${local.aws_account}:function:${var.env}-${item.microservice}-${item.type}-${item.operation}",
  }}
}

data "aws_iam_policy_document" "appsync_api_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["appsync.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
  }
}
data "aws_iam_policy_document" "appsync_api_public_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["appsync.amazonaws.com"]
      type        = "Service"
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "appsync_api" {
  name               = "appsync_api_${var.api_name}_${local.prefix}"
  assume_role_policy = data.aws_iam_policy_document.appsync_api_assume_role.json
}
resource "aws_iam_role" "appsync_api_public" {
  name               = "appsync_api_public_${var.api_name}_${local.prefix}"
  assume_role_policy = data.aws_iam_policy_document.appsync_api_public_assume_role.json
}

module "sns-outgoing-topic" {
  source = "../sns-topic"
  name   = "${local.prefix}-outgoing"
}

module "sqs-incoming-queue" {
  source = "../sqs-to-lambda"
  name   = "${local.prefix}-incoming"
}

module "dynamodb-table-migration" {
  source     = "../dynamodb-table"
  name       = "${local.table_prefix}migration"
  attributes = {id = {type = "S"}}
  indexes    = {}
}

resource "aws_s3_bucket" "bucket" {
  for_each = var.buckets
  bucket   = "${replace(local.bucket_prefix, "{PREFIX}", lookup(each.value, "prefix", ""))}-${each.key}"
  tags     = merge(each.value.tags, {Env = var.env, Microservice = var.name})
  acl      = "private"
  dynamic "cors_rule" {
    for_each = lookup(each.value, "cors", false) ? {cors: true} : {}
    content {
      allowed_headers = ["*"]
      allowed_methods = ["POST", "GET"]
      allowed_origins = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  }
}

module "sns-to-local-sqs-events" {
  source         = "../sns-to-sqs-subscriptions"
  subscriptions  = {
    local = {
      topic = module.sns-outgoing-topic.arn
      queue = module.sqs-incoming-queue.arn
    }
  }
}
