locals {
  all = merge(var.queries, var.mutations)
  all_idx = keys(merge(var.queries, var.mutations))
}

resource "aws_appsync_datasource" "lambda" {
  for_each         = local.all
  api_id           = var.api
  name             = replace(each.key, "-", "_")
  type             = "AWS_LAMBDA"
  service_role_arn = aws_iam_role.appsync_api.arn
  lambda_config {
    function_arn = lookup(each.value, "arn", "unknown-arn")
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
    resources = [for o in local.all : lookup(o, "arn", "unknown-arn")]
  }
}

resource "aws_iam_role" "appsync_api" {
  name = "appsync_api_${var.api_name}_${var.name}"
  assume_role_policy = data.aws_iam_policy_document.appsync_api_assume_role.json
}

resource "aws_iam_role_policy" "appsync_api_policy" {
  name = "appsync_api_${var.api_name}_${var.name}_policy"
  role = aws_iam_role.appsync_api.id
  policy = data.aws_iam_policy_document.appsync_api_role.json
}

resource "aws_appsync_resolver" "query" {
  for_each = var.queries
  api_id            = var.api
  field             = each.key
  type              = lookup(each.value, "type", "Query")
  data_source       = aws_appsync_datasource.lambda[index(local.all_idx, each.key)].name
  request_template  = templatefile("${path.module}/files/query-request.vm.tpl", {sourcePrefix: ("Query" == lookup(each.value, "type", "Query")) ? "" : "${lower(substr(lookup(each.value, "type", "Unknown"), 0, 1))}${substr(lookup(each.value, "type", "Unknown"), 1, length(lookup(each.value, "type", "Unknown")) - 1)}_"})
  response_template = templatefile("${path.module}/files/query-response.vm.tpl", {})
}

resource "aws_appsync_resolver" "mutation" {
  for_each = var.mutations
  api_id            = var.api
  field             = each.key
  type              = "Mutation"
  data_source       = aws_appsync_datasource.lambda[index(local.all_idx, each.key)].name
  request_template  = file("${path.module}/files/mutation-request.vm")
  response_template = file("${path.module}/files/mutation-response.vm")
}