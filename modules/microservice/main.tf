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
  bucket   = "${local.prefix}-${lookup(each.value, prefix, "")}-${each.key}"
  tags     = merge(each.value.tags, {Env = var.env, Microservice = var.name})
}