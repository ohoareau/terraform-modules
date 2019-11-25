locals {
  name_plural       = ("" != var.name_plural) ? var.name_plural : "${var.name}s"
  upper_name        = title(var.name)
  upper_name_plural = title(("" != var.name_plural) ? var.name_plural : "${var.name}s")
  prefix            = "${var.env}-${var.name}"
  operations = {
    events  = lookup(var.operations, "events", {policy_statements = [], variables = {}})
    migrate = lookup(var.operations, "migrate", {policy_statements = [], variables = {}})
    list    = lookup(var.operations, "list", {policy_statements = [], variables = {}})
    get     = lookup(var.operations, "get", {policy_statements = [], variables = {}})
    delete  = lookup(var.operations, "delete", {policy_statements = [], variables = {}})
    create  = lookup(var.operations, "create", {policy_statements = [], variables = {}})
    update  = lookup(var.operations, "update", {policy_statements = [], variables = {}})
  }
  enabled_operations = {
    events  = lookup(var.enabled_operations, "events", true)
    migrate = lookup(var.enabled_operations, "migrate", true)
    list    = lookup(var.enabled_operations, "list", true)
    get     = lookup(var.enabled_operations, "get", true)
    delete  = lookup(var.enabled_operations, "delete", true)
    create  = lookup(var.enabled_operations, "create", true)
    update  = lookup(var.enabled_operations, "update", true)
  }
  enabled_public_operations = {
    events  = length([for k,v in var.public_api_mutation_aliases: true if v.operation == "events"]) > 0
    migrate = length([for k,v in var.public_api_mutation_aliases: true if v.operation == "migrate"]) > 0
    list    = length([for k,v in var.public_api_query_aliases: true if v.operation == "list"]) > 0
    get     = length([for k,v in var.public_api_query_aliases: true if v.operation == "get"]) > 0
    delete  = length([for k,v in var.public_api_mutation_aliases: true if v.operation == "delete"]) > 0
    create  = length([for k,v in var.public_api_mutation_aliases: true if v.operation == "create"]) > 0
    update  = length([for k,v in var.public_api_mutation_aliases: true if v.operation == "update"]) > 0
  }
  enabled_public = (
       length([for k,v in var.public_api_mutation_aliases: true if v.operation == "events"]) > 0
    || length([for k,v in var.public_api_mutation_aliases: true if v.operation == "migrate"]) > 0
    || length([for k,v in var.public_api_query_aliases: true if v.operation == "list"]) > 0
    || length([for k,v in var.public_api_query_aliases: true if v.operation == "get"]) > 0
    || length([for k,v in var.public_api_mutation_aliases: true if v.operation == "delete"]) > 0
    || length([for k,v in var.public_api_mutation_aliases: true if v.operation == "create"]) > 0
    || length([for k,v in var.public_api_mutation_aliases: true if v.operation == "update"]) > 0
  )
  api_operations = {
    events  = lookup(var.api_operations, "events", false)
    migrate = lookup(var.api_operations, "migrate", true)
    list    = lookup(var.api_operations, "list", true)
    get     = lookup(var.api_operations, "get", true)
    delete  = lookup(var.api_operations, "delete", true)
    create  = lookup(var.api_operations, "create", true)
    update  = lookup(var.api_operations, "update", true)
  }
  api_events_aliases = [for k,v in var.api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "events"]
  api_migrate_aliases = [for k,v in var.api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "migrate"]
  api_list_aliases = [for k,v in var.api_query_aliases: {name: k, type: lookup(v.config, "type", "Query"), config: v.config} if v.operation == "list"]
  api_get_aliases = [for k,v in var.api_query_aliases: {name: k, type: lookup(v.config, "type", "Query"), config: v.config} if v.operation == "get"]
  api_delete_aliases = [for k,v in var.api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "delete"]
  api_create_aliases = [for k,v in var.api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "create"]
  api_update_aliases = [for k,v in var.api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "update"]

  public_api_events_aliases = [for k,v in var.public_api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "events"]
  public_api_migrate_aliases = [for k,v in var.public_api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "migrate"]
  public_api_list_aliases = [for k,v in var.public_api_query_aliases: {name: k, type: lookup(v.config, "type", "Query"), config: v.config} if v.operation == "list"]
  public_api_get_aliases = [for k,v in var.public_api_query_aliases: {name: k, type: lookup(v.config, "type", "Query"), config: v.config} if v.operation == "get"]
  public_api_delete_aliases = [for k,v in var.public_api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "delete"]
  public_api_create_aliases = [for k,v in var.public_api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "create"]
  public_api_update_aliases = [for k,v in var.public_api_mutation_aliases: {name: k, type: lookup(v.config, "type", "Mutation"), config: v.config} if v.operation == "update"]

  tables_attributes = {
    main      = lookup(var.tables_attributes, "main", {id = {type: "S"}})
    migration = lookup(var.tables_attributes, "migration", {id = {type: "S"}})
  }
  tables_indexes = {
    main      = lookup(var.tables_indexes, "main", {})
    migration = lookup(var.tables_indexes, "migration", {})
  }
  queues_sources = {
    incoming = lookup(var.queues, "incoming", {sources = []}).sources
  }
  extra_variables = var.debug ? {MICROSERVICE_DEBUG = "true"} : {}
}

module "lambda-events" {
  source    = "../lambda"
  enabled   = local.enabled_operations.events
  file      = var.file
  name      = "${local.prefix}-events"
  handler   = "index.receive${local.upper_name}ExternalEvents"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX = "${var.env}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
    },
    local.operations.events.variables,
    local.extra_variables
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
  handler   = "index.migrate${local.upper_name_plural}"
  variables = merge(
    {
      DYNAMODB_TABLE_PREFIX           = "${var.env}_",
      DYNAMODB_MIGRATION_TABLE_PREFIX = "${var.env}_${local.upper_name}_",
      MICROSERVICE_OUTGOING_TOPIC_ARN = module.sns-outgoing-topic.arn,
      LAMBDA_CREATE_ARN               = module.lambda-create.arn,
      LAMBDA_UPDATE_ARN               = module.lambda-update.arn,
      LAMBDA_DELETE_ARN               = module.lambda-delete.arn,
      LAMBDA_GET_ARN                  = module.lambda-get.arn,
      LAMBDA_LIST_ARN                 = module.lambda-list.arn,
      LAMBDA_EVENTS_ARN               = module.lambda-events.arn,
    },
    local.operations.migrate.variables,
    local.extra_variables
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
      },
      {
        actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query", "dynamodb:DeleteItem", "dynamodb:PutItem", "dynamodb:UpdateItem"]
        resources = [module.dynamodb-table.arn, "${module.dynamodb-table.arn}/index/*"]
        effect    = "Allow"
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
    local.operations.list.variables,
    local.extra_variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:ListItem", "dynamodb:DescribeTable", "dynamodb:Scan", "dynamodb:Query"]
        resources = [module.dynamodb-table.arn, "${module.dynamodb-table.arn}/index/*"]
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
    local.operations.get.variables,
    local.extra_variables
  )
  policy_statements = concat(
    [
      {
        actions   = ["dynamodb:GetItem", "dynamodb:DescribeTable"]
        resources = [module.dynamodb-table.arn, "${module.dynamodb-table.arn}/index/*"]
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
    local.operations.delete.variables,
    local.extra_variables
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
    local.operations.create.variables,
    local.extra_variables
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
    local.operations.update.variables,
    local.extra_variables
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
  enabled = local.enabled_operations.events && local.api_operations.events
  api = var.api
  name = "${local.prefix}-events"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-events.arn
}
module "datasource-lambda-events-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.events
  api = var.public_api
  name = "${local.prefix}-events"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-events.arn
}
module "datasource-lambda-migrate" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.migrate && local.api_operations.migrate
  api = var.api
  name = "${local.prefix}-migrate"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-migrate.arn
}
module "datasource-lambda-migrate-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.migrate
  api = var.public_api
  name = "${local.prefix}-migrate"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-migrate.arn
}
module "datasource-lambda-list" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.list && local.api_operations.list
  api = var.api
  name = "${local.prefix}-list"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-list.arn
}
module "datasource-lambda-list-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.list
  api = var.public_api
  name = "${local.prefix}-list"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-list.arn
}
module "datasource-lambda-get" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.get && local.api_operations.get
  api = var.api
  name = "${local.prefix}-get"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-get.arn
}
module "datasource-lambda-get-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.get
  api = var.public_api
  name = "${local.prefix}-get"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-get.arn
}
module "datasource-lambda-delete" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.delete && local.api_operations.delete
  api = var.api
  name = "${local.prefix}-delete"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-delete.arn
}
module "datasource-lambda-delete-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.delete
  api = var.public_api
  name = "${local.prefix}-delete"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-delete.arn
}
module "datasource-lambda-create" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.create && local.api_operations.create
  api = var.api
  name = "${local.prefix}-create"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-create.arn
}
module "datasource-lambda-create-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.create
  api = var.public_api
  name = "${local.prefix}-create"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-create.arn
}
module "datasource-lambda-update" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_operations.update && local.api_operations.update
  api = var.api
  name = "${local.prefix}-update"
  api_assume_role_arn = module.api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-update.arn
}
module "datasource-lambda-update-public" {
  source = "../appsync-lambda-datasource"
  enabled = local.enabled_public_operations.update
  api = var.public_api
  name = "${local.prefix}-update"
  api_assume_role_arn = module.public-api-resolvers.api_assume_role_arn
  lambda_arn = module.lambda-update.arn
}

module "api-resolvers" {
  source   = "../appsync-lambda-resolvers"
  api      = var.api
  api_name = var.api_name
  name     = "${var.env}-microservice-${var.name}"
  lambdas = concat(
    local.api_operations.events ? [module.lambda-events.arn] : [],
    local.api_operations.migrate ? [module.lambda-migrate.arn] : [],
    local.api_operations.list ? [module.lambda-list.arn] : [],
    local.api_operations.get ? [module.lambda-get.arn] : [],
    local.api_operations.delete ? [module.lambda-delete.arn] : [],
    local.api_operations.create ? [module.lambda-create.arn] : [],
    local.api_operations.update ? [module.lambda-update.arn] : []
  )
  datasources = zipmap(
    concat(
      local.api_operations.events ? ["receive${local.upper_name}ExternalEvents"] : [],
      local.api_operations.migrate ? ["migrateMicroservice${local.upper_name}"] : [],
      local.api_operations.list ? ["get${local.upper_name_plural}"] : [],
      local.api_operations.get ? ["get${local.upper_name}"] : [],
      local.api_operations.delete ? ["delete${local.upper_name}"] : [],
      local.api_operations.create ? ["create${local.upper_name}"] : [],
      local.api_operations.update ? ["update${local.upper_name}"] : [],
      [for o in local.api_events_aliases: o.name],
      [for o in local.api_migrate_aliases: o.name],
      [for o in local.api_list_aliases: o.name],
      [for o in local.api_get_aliases: o.name],
      [for o in local.api_delete_aliases: o.name],
      [for o in local.api_create_aliases: o.name],
      [for o in local.api_update_aliases: o.name]
    ),
    concat(
      local.api_operations.events ? [module.datasource-lambda-events.name] : [],
      local.api_operations.migrate ? [module.datasource-lambda-migrate.name] : [],
      local.api_operations.list ? [module.datasource-lambda-list.name] : [],
      local.api_operations.get ? [module.datasource-lambda-get.name] : [],
      local.api_operations.delete ? [module.datasource-lambda-delete.name] : [],
      local.api_operations.create ? [module.datasource-lambda-create.name] : [],
      local.api_operations.update ? [module.datasource-lambda-update.name] : [],
      [for o in local.api_events_aliases: module.datasource-lambda-events.name],
      [for o in local.api_migrate_aliases: module.datasource-lambda-migrate.name],
      [for o in local.api_list_aliases: module.datasource-lambda-list.name],
      [for o in local.api_get_aliases: module.datasource-lambda-get.name],
      [for o in local.api_delete_aliases: module.datasource-lambda-delete.name],
      [for o in local.api_create_aliases: module.datasource-lambda-create.name],
      [for o in local.api_update_aliases: module.datasource-lambda-update.name]
    )
  )
  queries  = merge(
    local.api_operations.list ? zipmap(["get${local.upper_name_plural}"], [{type = "Query", config = {}}]) : {},
    local.api_operations.get ? zipmap(["get${local.upper_name}"], [{type = "Query", config = {}}]) : {},
    zipmap([for o in local.api_list_aliases: o.name], [for o in local.api_list_aliases: o]),
    zipmap([for o in local.api_get_aliases: o.name], [for o in local.api_get_aliases: o])
  )
  mutations = merge(
    local.api_operations.events ? zipmap(["receive${local.upper_name}ExternalEvents"], [{type = "Mutation", config = {}}]) : {},
    local.api_operations.migrate ? zipmap(["migrateMicroservice${local.upper_name}"], [{type = "Mutation", config = {}}]) : {},
    local.api_operations.delete ? zipmap(["delete${local.upper_name}"], [{type = "Mutation", config = {}}]) : {},
    local.api_operations.create ? zipmap(["create${local.upper_name}"], [{type = "Mutation", config = {}}]) : {},
    local.api_operations.update ? zipmap(["update${local.upper_name}"], [{type = "Mutation", config = {}}]) : {},
    zipmap([for o in local.api_events_aliases: o.name], [for o in local.api_events_aliases: o]),
    zipmap([for o in local.api_migrate_aliases: o.name], [for o in local.api_migrate_aliases: o]),
    zipmap([for o in local.api_delete_aliases: o.name], [for o in local.api_delete_aliases: o]),
    zipmap([for o in local.api_create_aliases: o.name], [for o in local.api_create_aliases: o]),
    zipmap([for o in local.api_update_aliases: o.name], [for o in local.api_update_aliases: o])
  )
}

module "public-api-resolvers" {
  source   = "../appsync-lambda-resolvers"
  enabled  = local.enabled_public
  api      = var.public_api
  api_name = var.public_api_name
  name     = "${var.env}-microservice-${var.name}-public"
  lambdas = concat(
    local.enabled_public_operations.events ? [module.lambda-events.arn] : [],
    local.enabled_public_operations.migrate ? [module.lambda-migrate.arn] : [],
    local.enabled_public_operations.list ? [module.lambda-list.arn] : [],
    local.enabled_public_operations.get ? [module.lambda-get.arn] : [],
    local.enabled_public_operations.delete ? [module.lambda-delete.arn] : [],
    local.enabled_public_operations.create ? [module.lambda-create.arn] : [],
    local.enabled_public_operations.update ? [module.lambda-update.arn] : []
  )
  datasources = zipmap(
    concat(
      [for o in local.public_api_events_aliases: o.name],
      [for o in local.public_api_migrate_aliases: o.name],
      [for o in local.public_api_list_aliases: o.name],
      [for o in local.public_api_get_aliases: o.name],
      [for o in local.public_api_delete_aliases: o.name],
      [for o in local.public_api_create_aliases: o.name],
      [for o in local.public_api_update_aliases: o.name]
    ),
    concat(
      [for o in local.public_api_events_aliases: module.datasource-lambda-events-public.name],
      [for o in local.public_api_migrate_aliases: module.datasource-lambda-migrate-public.name],
      [for o in local.public_api_list_aliases: module.datasource-lambda-list-public.name],
      [for o in local.public_api_get_aliases: module.datasource-lambda-get-public.name],
      [for o in local.public_api_delete_aliases: module.datasource-lambda-delete-public.name],
      [for o in local.public_api_create_aliases: module.datasource-lambda-create-public.name],
      [for o in local.public_api_update_aliases: module.datasource-lambda-update-public.name]
    )
  )
  queries  = merge(
    zipmap([for o in local.public_api_list_aliases: o.name], [for o in local.public_api_list_aliases: o]),
    zipmap([for o in local.public_api_get_aliases: o.name], [for o in local.public_api_get_aliases: o])
  )
  mutations = merge(
    zipmap([for o in local.public_api_events_aliases: o.name], [for o in local.public_api_events_aliases: o]),
    zipmap([for o in local.public_api_migrate_aliases: o.name], [for o in local.public_api_migrate_aliases: o]),
    zipmap([for o in local.public_api_delete_aliases: o.name], [for o in local.public_api_delete_aliases: o]),
    zipmap([for o in local.public_api_create_aliases: o.name], [for o in local.public_api_create_aliases: o]),
    zipmap([for o in local.public_api_update_aliases: o.name], [for o in local.public_api_update_aliases: o])
  )
}

module "dynamodb-table" {
  source = "../dynamodb-table"
  name = "${var.env}_${local.upper_name}"
  attributes = local.tables_attributes.main
  indexes    = local.tables_indexes.main

}

module "dynamodb-table-migration" {
  source = "../dynamodb-table"
  name = "${var.env}_${local.upper_name}_Migration"
  attributes = local.tables_attributes.migration
  indexes    = local.tables_indexes.migration
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

