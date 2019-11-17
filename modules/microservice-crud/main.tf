locals {
  name_plural       = ("" != var.name_plural) ? var.name_plural : "${var.name}s"
  upper_name        = title(var.name)
  upper_name_plural = title(("" != var.name_plural) ? var.name_plural : "${var.name}s")
  prefix            = "${var.env}-${var.name}"
  operations = {
    events = merge({api = false, enabled = true, policy_statements = []}, lookup(var.operations, "events", {}))
    list   = merge({api = true, enabled = true, policy_statements = []}, lookup(var.operations, "list", {}))
    get    = merge({api = true, enabled = true, policy_statements = []}, lookup(var.operations, "get", {}))
    delete = merge({api = true, enabled = true, policy_statements = []}, lookup(var.operations, "delete", {}))
    create = merge({api = true, enabled = true, policy_statements = []}, lookup(var.operations, "create", {}))
    update = merge({api = true, enabled = true, policy_statements = []}, lookup(var.operations, "update", {}))
  }
  enabled_operations = {
    events = false != lookup(lookup(var.operations, "events", {enabled = true}), "enabled", true)
    list   = false != lookup(lookup(var.operations, "list", {enabled = true}), "enabled", true)
    get    = false != lookup(lookup(var.operations, "get", {enabled = true}), "enabled", true)
    delete = false != lookup(lookup(var.operations, "delete", {enabled = true}), "enabled", true)
    create = false != lookup(lookup(var.operations, "create", {enabled = true}), "enabled", true)
    update = false != lookup(lookup(var.operations, "update", {enabled = true}), "enabled", true)
  }
}

module "lambda-events" {
  source    = "../lambda"
  enabled   = local.enabled_operations.events
  file      = var.file
  name      = "${local.prefix}-events"
  handler   = "index.receiveExternalEvents"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.env,
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    lookup(local.operations.events, "variables", {})
  )
}
module "lambda-list" {
  source    = "../lambda"
  enabled   = local.enabled_operations.list
  file      = var.file
  name      = "${local.prefix}-list"
  handler   = "index.get${local.upper_name_plural}"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.env
    },
    lookup(local.operations.list, "variables", {})
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query"]
        resources = [module.dynamodb-table.arn]
      }
    ],
    lookup(local.operations.list, "policy_statements", [])
  )
}
module "lambda-get" {
  source    = "../lambda"
  enabled   = local.enabled_operations.get
  file      = var.file
  name      = "${local.prefix}-get"
  handler   = "index.get${local.upper_name}"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.env
    },
    lookup(local.operations.get, "variables", {})
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable"]
        resources = [module.dynamodb-table.arn]
      }
    ],
    lookup(local.operations.get, "policy_statements", [])
  )
}
module "lambda-delete" {
  source    = "../lambda"
  enabled   = local.enabled_operations.delete
  file      = var.file
  name      = "${local.prefix}-delete"
  handler   = "index.delete${local.upper_name}"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.env,
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    lookup(local.operations.delete, "variables", {})
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable", "dynamodb:PutItem"]
        resources = [module.dynamodb-table.arn]
      },
      {
        actions   = ["SNS:Publish"]
        resources = [module.sns-outgoing-topic.arn]
      }
    ],
    lookup(local.operations.delete, "policy_statements", [])
  )
}
module "lambda-create" {
  source = "../lambda"
  enabled = local.enabled_operations.create
  file = var.file
  name = "${local.prefix}-create"
  handler = "index.create${local.upper_name}"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.env,
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    lookup(local.operations.create, "variables", {})
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable", "dynamodb:PutItem"]
        resources = [module.dynamodb-table.arn]
      },
      {
        actions   = ["SNS:Publish"]
        resources = [module.sns-outgoing-topic.arn]
      }
    ],
    lookup(local.operations.create, "policy_statements", [])
  )
}
module "lambda-update" {
  source = "../lambda"
  enabled = local.enabled_operations.update
  file = var.file
  name = "${local.prefix}-update"
  handler = "index.update${local.upper_name}"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = var.env,
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    lookup(local.operations.update, "variables", {})
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:UpdateItem", "dynamodb:DescribeTable"]
        resources = [module.dynamodb-table.arn]
      },
      {
        actions   = ["SNS:Publish"]
        resources = [module.sns-outgoing-topic.arn]
      }
    ],
    lookup(local.operations.update, "policy_statements", [])
  )
}

module "datasource-lambda-events" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.events && lookup(local.operations.events, "api", false)
  api = var.api
  name = "${local.prefix}-events"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-events.arn
}
module "datasource-lambda-list" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.list && lookup(local.operations.list, "api", false)
  api = var.api
  name = "${local.prefix}-list"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-list.arn
}
module "datasource-lambda-get" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.get && lookup(local.operations.get, "api", false)
  api = var.api
  name = "${local.prefix}-get"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-get.arn
}
module "datasource-lambda-delete" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.delete && lookup(local.operations.delete, "api", false)
  api = var.api
  name = "${local.prefix}-delete"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-delete.arn
}
module "datasource-lambda-create" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.create && lookup(local.operations.create, "api", false)
  api = var.api
  name = "${local.prefix}-create"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-create.arn
}
module "datasource-lambda-update" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.update && lookup(local.operations.update, "api", false)
  api = var.api
  name = "${local.prefix}-update"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-update.arn
}

module "api-resolvers" {
  source   = "../appsync-lambda-resolvers"
  api      = var.api
  api_name = var.api_name
  name     = "${var.env}-microservice-${var.name}"
  lambdas = concat(
    (false != lookup(local.operations.events, "api", false)) ? [module.lambda-events.arn] : [],
    (false != lookup(local.operations.list, "api", false)) ? [module.lambda-list.arn] : [],
    (false != lookup(local.operations.get, "api", false)) ? [module.lambda-get.arn] : [],
    (false != lookup(local.operations.delete, "api", false)) ? [module.lambda-delete.arn] : [],
    (false != lookup(local.operations.create, "api", false)) ? [module.lambda-create.arn] : [],
    (false != lookup(local.operations.update, "api", false)) ? [module.lambda-update.arn] : []
  )
  datasources = zipmap(
    concat(
      (false != lookup(local.operations.events, "api", false)) ? ["receiveExternalEvents"] : [],
      (false != lookup(local.operations.list, "api", false)) ? ["get${local.upper_name_plural}"] : [],
      (false != lookup(local.operations.get, "api", false)) ? ["get${local.upper_name}"] : [],
      (false != lookup(local.operations.delete, "api", false)) ? ["delete${local.upper_name}"] : [],
      (false != lookup(local.operations.create, "api", false)) ? ["create${local.upper_name}"] : [],
      (false != lookup(local.operations.update, "api", false)) ? ["update${local.upper_name}"] : []
    ),
    concat(
      (false != lookup(local.operations.events, "api", false)) ? [module.datasource-lambda-events.name] : [],
      (false != lookup(local.operations.list, "api", false)) ? [module.datasource-lambda-list.name] : [],
      (false != lookup(local.operations.get, "api", false)) ? [module.datasource-lambda-get.name] : [],
      (false != lookup(local.operations.delete, "api", false)) ? [module.datasource-lambda-delete.name] : [],
      (false != lookup(local.operations.create, "api", false)) ? [module.datasource-lambda-create.name] : [],
      (false != lookup(local.operations.update, "api", false)) ? [module.datasource-lambda-update.name] : []
    )
  )
  queries  = merge(
    (false != lookup(local.operations.list, "api", false)) ? zipmap(["get${local.upper_name_plural}"], [{}]) : {},
    (false != lookup(local.operations.get, "api", false)) ? zipmap(["get${local.upper_name}"], [{}]) : {}
  )
  mutations = merge(
    (false != lookup(local.operations.events, "api", false)) ? {receiveExternalEvents = {}} : {},
    (false != lookup(local.operations.delete, "api", false)) ? zipmap(["delete${local.upper_name}"], [{}]) : {},
    (false != lookup(local.operations.create, "api", false)) ? zipmap(["create${local.upper_name}"], [{}]) : {},
    (false != lookup(local.operations.update, "api", false)) ? zipmap(["update${local.upper_name}"], [{}]) : {}
  )
}

module "dynamodb-table" {
  source = "../dynamodb-table"
  name = "${var.env}_${var.name}"
}

module "sns-outgoing-topic" {
  source = "../sns-topic"
  name = "${local.prefix}-outgoing"
  sources = [
    module.lambda-events.arn,
    module.lambda-delete.arn,
    module.lambda-create.arn,
    module.lambda-update.arn,
  ]
}

module "sqs-incoming-queue" {
  source = "../sqs-to-lambda"
  name = "${local.prefix}-incoming"
  lambda_arn = module.lambda-events.arn
  lambda_role_name = module.lambda-events.role_name
}