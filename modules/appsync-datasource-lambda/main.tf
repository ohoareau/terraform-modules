locals {
  full_name = "${var.api_name != "" ? var.api_name : ""}${var.api_name != "" ? "_" : ""}${var.name}"
}

resource "aws_appsync_datasource" "lambda" {
  api_id           = var.api
  name             = replace(var.name, "-", "_")
  type             = "AWS_LAMBDA"
  service_role_arn = aws_iam_role.appsync_api.arn
  lambda_config {
    function_arn = var.lambda_arn
  }
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
data "aws_iam_policy_document" "appsync_api_role" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [var.lambda_arn]
  }
}

resource "aws_iam_role" "appsync_api" {
  name = "appsync_api_${local.full_name}"
  assume_role_policy = data.aws_iam_policy_document.appsync_api_assume_role.json
}

resource "aws_iam_role_policy" "appsync_api_policy" {
  name = "appsync_api_${local.full_name}_policy"
  role = aws_iam_role.appsync_api.id
  policy = data.aws_iam_policy_document.appsync_api_role.json
}
