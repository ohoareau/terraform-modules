output "env" {
  value = var.env
}
output "debug" {
  value = var.debug
}
output "file" {
  value = var.file
}
output "name" {
  value = var.name
}
output "prefix" {
  value = local.prefix
}
output "table_prefix" {
  value = local.table_prefix
}
output "variables" {
  value = local.variables
}
output "apis" {
  value = {
    main = {
      id = var.api
      name = var.api_name
      assume_role_arn = aws_iam_role.appsync_api.arn
      assume_role = aws_iam_role.appsync_api.id
    }
    public = {
      id = var.public_api
      name = var.public_api_name
      assume_role_arn = aws_iam_role.appsync_api_public.arn
      assume_role = aws_iam_role.appsync_api_public.id
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
      sources = []
    }
  }
}
output "lambdas" {
  value = {
    events = {
      arn = module.lambda-events.arn
      role_name = module.lambda-events.role_name
      role_arn = module.lambda-events.role_arn
    }
    migrate = {
      arn = module.lambda-migrate.arn
      role_name = module.lambda-migrate.role_name
      role_arn = module.lambda-migrate.role_arn
    }
  }
}
output "dynamodb_tables" {
  value = {
    migration = {
      arn  = module.dynamodb-table-migration.arn
      name = module.dynamodb-table-migration.name
    }
  }
}
