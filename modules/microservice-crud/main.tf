locals {
  name_plural       = ("" != var.name_plural) ? var.name_plural : "${var.name}s"
  upper_name        = title(var.name)
  upper_name_plural = title(("" != var.name_plural) ? var.name_plural : "${var.name}s")
  prefix            = "${var.env}-${var.name}"
  operations = {
    events  = lookup(var.operations, "events", {api = false, enabled = true, policy_statements = [], variables = {}})
    migrate = lookup(var.operations, "migrate", {api = true, enabled = true, policy_statements = [], variables = {}})
    list    = lookup(var.operations, "list", {api = true, enabled = true, policy_statements = [], variables = {}})
    get     = lookup(var.operations, "get", {api = true, enabled = true, policy_statements = [], variables = {}})
    delete  = lookup(var.operations, "delete", {api = true, enabled = true, policy_statements = [], variables = {}})
    create  = lookup(var.operations, "create", {api = true, enabled = true, policy_statements = [], variables = {}})
    update  = lookup(var.operations, "update", {api = true, enabled = true, policy_statements = [], variables = {}})
  }
  enabled_operations = {
    events  = lookup(var.operations, "events", {api = false, enabled = true, policy_statements = [], variables = {}}).enabled
    migrate = lookup(var.operations, "migrate", {api = true, enabled = true, policy_statements = [], variables = {}}).enabled
    list    = lookup(var.operations, "list", {api = true, enabled = true, policy_statements = [], variables = {}}).enabled
    get     = lookup(var.operations, "get", {api = true, enabled = true, policy_statements = [], variables = {}}).enabled
    delete  = lookup(var.operations, "delete", {api = true, enabled = true, policy_statements = [], variables = {}}).enabled
    create  = lookup(var.operations, "create", {api = true, enabled = true, policy_statements = [], variables = {}}).enabled
    update  = lookup(var.operations, "update", {api = true, enabled = true, policy_statements = [], variables = {}}).enabled
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
      DYNAMODB_TABLE_PREFIX = "${var.env}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    local.operations.events.variables
  )
  policy_statements = concat(
    [],
    local.operations.events.policy_statements
  )
}
module "lambda-migrate" {
  source    = "../lambda"
  enabled   = local.enabled_operations.migrate
  file      = var.file
  name      = "${local.prefix}-migrate"
  handler   = "index.migrate"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX           = "${var.env}_",
      DYNAMODB_MIGRATION_TABLE_PREFIX = "${local.upper_name}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
      LAMBDA_CREATE_ARN               = module.lambda-create.arn,
      LAMBDA_UPDATE_ARN               = module.lambda-update.arn,
      LAMBDA_DELETE_ARN               = module.lambda-delete.arn,
      LAMBDA_GET_ARN                  = module.lambda-get.arn,
      LAMBDA_LIST_ARN                 = module.lambda-list.arn,
      LAMBDA_EVENTS_ARN               = module.lambda-events.arn,
    },
    local.operations.migrate.variables
  )
  policy_statements = concat(
    [
      {
        actions = ["lambda:InvokeFunction"]
        resources = [
          module.lambda-create.arn,
          module.lambda-update.arn,
          module.lambda-delete.arn,
          module.lambda-get.arn,
          module.lambda-list.arn,
          module.lambda-events.arn,
        ]
        effect = "Allow"
      }
    ],
    local.operations.migrate.policy_statements
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
      DYNAMODB_TABLE_PREFIX = "${var.env}_"
    },
    local.operations.list.variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query"]
        resources = [module.dynamodb-table.arn]
        effect    = "Allow"
      }
    ],
    local.operations.list.policy_statements
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
      DYNAMODB_TABLE_PREFIX = "${var.env}_"
    },
    local.operations.get.variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable"]
        resources = [module.dynamodb-table.arn]
        effect    = "Allow"
      }
    ],
    local.operations.get.policy_statements
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
      DYNAMODB_TABLE_PREFIX = "${var.env}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    local.operations.delete.variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable", "dynamodb:PutItem"]
        resources = [module.dynamodb-table.arn]
        effect    = "Allow"
      },
      {
        actions   = ["SNS:Publish"]
        resources = [module.sns-outgoing-topic.arn]
        effect    = "Allow"
      }
    ],
    local.operations.delete.policy_statements
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
      DYNAMODB_TABLE_PREFIX = "${var.env}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    local.operations.create.variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DeleteItem", "dynamodb:DescribeTable", "dynamodb:PutItem"]
        resources = [module.dynamodb-table.arn]
        effect    = "Allow"
      },
      {
        actions   = ["SNS:Publish"]
        resources = [module.sns-outgoing-topic.arn]
        effect    = "Allow"
      }
    ],
    local.operations.create.policy_statements
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
      DYNAMODB_TABLE_PREFIX = "${var.env}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    local.operations.update.variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:UpdateItem", "dynamodb:DescribeTable"]
        resources = [module.dynamodb-table.arn]
        effect    = "Allow"
      },
      {
        actions   = ["SNS:Publish"]
        resources = [module.sns-outgoing-topic.arn]
        effect    = "Allow"
      }
    ],
    local.operations.update.policy_statements
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
module "datasource-lambda-migrate" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.migrate && lookup(local.operations.migrate, "api", false)
  api = var.api
  name = "${local.prefix}-migrate"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-migrate.arn
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
    local.operations.events.api ? [module.lambda-events.arn] : [],
    local.operations.migrate.api ? [module.lambda-migrate.arn] : [],
    local.operations.list.api ? [module.lambda-list.arn] : [],
    local.operations.get.api ? [module.lambda-get.arn] : [],
    local.operations.delete.api ? [module.lambda-delete.arn] : [],
    local.operations.create.api ? [module.lambda-create.arn] : [],
    local.operations.update.api ? [module.lambda-update.arn] : []
  )
  datasources = zipmap(
    concat(
      local.operations.events.api ? ["receiveExternalEvents"] : [],
      local.operations.migrate.api ? ["migrateMicroservice${local.upper_name}"] : [],
      local.operations.list.api ? ["get${local.upper_name_plural}"] : [],
      local.operations.get.api ? ["get${local.upper_name}"] : [],
      local.operations.delete.api ? ["delete${local.upper_name}"] : [],
      local.operations.create.api ? ["create${local.upper_name}"] : [],
      local.operations.update.api ? ["update${local.upper_name}"] : []
    ),
    concat(
      local.operations.events.api ? [module.datasource-lambda-events.name] : [],
      local.operations.migrate.api ? [module.datasource-lambda-migrate.name] : [],
      local.operations.list.api ? [module.datasource-lambda-list.name] : [],
      local.operations.get.api ? [module.datasource-lambda-get.name] : [],
      local.operations.delete.api ? [module.datasource-lambda-delete.name] : [],
      local.operations.create.api ? [module.datasource-lambda-create.name] : [],
      local.operations.update.api ? [module.datasource-lambda-update.name] : []
    )
  )
  queries  = merge(
    local.operations.list.api ? zipmap(["get${local.upper_name_plural}"], [{}]) : {},
    local.operations.get.api ? zipmap(["get${local.upper_name}"], [{}]) : {}
  )
  mutations = merge(
    local.operations.events.api ? {receiveExternalEvents = {}} : {},
    local.operations.migrate.api ? zipmap(["migrateMicroservice${local.upper_name}"], [{}]) : {},
    local.operations.delete.api ? zipmap(["delete${local.upper_name}"], [{}]) : {},
    local.operations.create.api ? zipmap(["create${local.upper_name}"], [{}]) : {},
    local.operations.update.api ? zipmap(["update${local.upper_name}"], [{}]) : {}
  )
}

module "dynamodb-table" {
  source = "../dynamodb-table"
  name = "${var.env}_${local.upper_name}"
}

module "dynamodb-table-migration" {
  source = "../dynamodb-table"
  name = "${var.env}_${local.upper_name}_Migration"
}

module "sns-outgoing-topic" {
  source = "../sns-topic"
  name = "${local.prefix}-outgoing"
  sources = [
    module.lambda-events.arn,
    module.lambda-migrate.arn,
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