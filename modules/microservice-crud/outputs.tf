output "lambdas" {
  value = {
    events = {
      arn       = module.lambda-events.arn
      name      = module.lambda-events.name
      role_arn  = module.lambda-events.role_arn
      role_name = module.lambda-events.role_name
    }
    migrate = {
      arn       = module.lambda-migrate.arn
      name      = module.lambda-migrate.name
      role_arn  = module.lambda-migrate.role_arn
      role_name = module.lambda-migrate.role_name
    }
    list = {
      arn       = module.lambda-list.arn
      name      = module.lambda-events.name
      role_arn  = module.lambda-list.role_arn
      role_name = module.lambda-list.role_name
    }
    get = {
      arn       = module.lambda-get.arn
      name      = module.lambda-events.name
      role_arn  = module.lambda-get.role_arn
      role_name = module.lambda-get.role_name
    }
    delete = {
      arn       = module.lambda-delete.arn
      name      = module.lambda-events.name
      role_arn  = module.lambda-delete.role_arn
      role_name = module.lambda-delete.role_name
    }
    create = {
      arn       = module.lambda-create.arn
      name      = module.lambda-events.name
      role_arn  = module.lambda-create.role_arn
      role_name = module.lambda-create.role_name
    }
    update = {
      arn       = module.lambda-update.arn
      name      = module.lambda-events.name
      role_arn  = module.lambda-update.role_arn
      role_name = module.lambda-update.role_name
    }
  }
}
output "sns_topics" {
  value = {
    outgoing = {
      arn = module.sns-outgoing-topic.arn
    }
  }
}
output "sqs_queues" {
  value = {
    incoming = {
      arn = module.sqs-incoming-queue.arn
      id  = module.sqs-incoming-queue.id
    }
  }
}
output "dynamodb_tables" {
  value = {
    main = {
      arn  = module.dynamodb-table.arn
      name = module.dynamodb-table.name
    }
    migration = {
      arn  = module.dynamodb-table-migration.arn
      name = module.dynamodb-table-migration.name
    }
  }
}