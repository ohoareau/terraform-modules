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
      url  = module.sqs-incoming-queue.url
      sources = [
        module.sns-outgoing-topic.arn,
      ]
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
output "s3_buckets" {
  value = aws_s3_bucket.bucket
}
output "tasks_cluster" {
  value = var.tasks_cluster
}
output "tasks_vpc_subnets" {
  value = var.tasks_vpc_subnets
}
output "tasks_vpc_security_groups" {
  value = var.tasks_vpc_security_groups
}
output "dlq_sns_topic" {
  value = var.dlq_sns_topic
}
output "required_types" {
  value = var.required_types
}