data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  datasources = {
    main   = var.name,
    public = "${var.name}-public",
  }
  aws_account = data.aws_caller_identity.current.account_id
  aws_region  = data.aws_region.current.name
  tags        = merge(var.tags, {
    Env          = var.microservice.env
    Microservice = var.microservice.name
  })
}

module "lambda" {
  source        = "../lambda"
  enabled       = var.enabled
  file          = var.microservice.file
  name          = var.name
  handler       = var.handler
  timeout       = var.timeout
  memory_size   = var.memory_size
  dlq_sns_topic = var.microservice.dlq_sns_topic
  tags          = local.tags
  variables     = merge(
    {
      MICROSERVICE_OUTGOING_TOPIC_ARN           = var.microservice.sns_topics.outgoing.arn,
      MICROSERVICE_PATTERN_LAMBDA_OPERATION_ARN = "arn:aws:lambda:${local.aws_region}:${local.aws_account}:function:${var.microservice.prefix}-{name}"
    },
    var.variables,
    var.microservice.variables
  )
  policy_statements = concat(
    var.policy_statements,
    [
      {
        actions   = ["SNS:Publish"]
        resources = [var.microservice.sns_topics.outgoing.arn]
        effect    = "Allow"
      },
      {
        effect    = "Allow"
        actions   = ["lambda:InvokeFunction"]
        resources = ["arn:aws:lambda:${local.aws_region}:${local.aws_account}:function:${var.microservice.prefix}-*"]
      },
    ]
  )
}

resource "aws_appsync_datasource" "datasources" {
  for_each = local.datasources
  api_id           = var.microservice.apis[each.key].id
  name             = replace(each.value, "-", "_")
  type             = "AWS_LAMBDA"
  service_role_arn = var.microservice.apis[each.key].assume_role_arn
  lambda_config {
    function_arn = module.lambda.arn
  }
}

resource "aws_appsync_resolver" "resolvers" {
  for_each          = {for r in var.resolvers: "${r.api}_${r.type}_${r.field}" => r}
  api_id            = var.microservice.apis[each.value.api].id
  field             = each.value.field
  type              = each.value.type
  data_source       = aws_appsync_datasource.datasources[each.value.api].name
  request_template  = templatefile("${path.module}/files/${each.value.mode}-request.vm.tpl", {config: each.value.config, sourcePrefix: ("Query" == each.value.type) ? "" : "${lower(substr(each.value.type, 0, 1))}${substr(each.value.type, 1, length(each.value.type) - 1)}_"})
  response_template = templatefile("${path.module}/files/${each.value.mode}-response.vm.tpl", {config: each.value.config})
}