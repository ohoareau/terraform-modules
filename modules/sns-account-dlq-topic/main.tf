data "aws_caller_identity" "current" {}

locals {
  name = "${var.env}-dlq"
}

module "sns-dlq-topic" {
  source = "../sns-topic"
  name   = local.name
}

resource "aws_sqs_queue" "dlq" {
  name = local.name
}

module "sns-dlq-topic-policy" {
  source  = "../sns-topic-policy"
  topic   = module.sns-dlq-topic.arn
  sources = ["arn:*:*:*:${data.aws_caller_identity.current.account_id}:*"]
}

module "sqs-dlq-policy" {
  source   = "../sqs-policy"
  policies = {
    dlq = {
      arn     = aws_sqs_queue.dlq.arn
      id      = aws_sqs_queue.dlq.id
      sources = [module.sns-dlq-topic.arn]
    }
  }
}

data "archive_file" "lambda-sqs-to-s3" {
  type        = "zip"
  output_path = "${path.module}/lambda-sqs-to-s3.zip"
  source_dir  = "${path.module}/files/lambda-sqs-to-s3"
}

resource "aws_s3_bucket" "dlq" {
  bucket = var.bucket_name
  tags   = {Env = var.env}
}

module "lambda-sqs-to-s3" {
  source      = "../lambda"
  file        = data.archive_file.lambda-sqs-to-s3.output_path
  name        = "${local.name}-sqs-to-s3"
  handler     = "index.handler"
  variables   = {
    S3_BUCKET_ID         = aws_s3_bucket.dlq.id
    S3_BUCKET_KEY_PREFIX = var.bucket_key_prefix
  }
  policy_statements = [
    {
      actions   = ["s3:PutObject"]
      resources = [aws_s3_bucket.dlq.arn]
      effect    = "Allow"
    },
  ]
}

module "lambda-event-source-mapping" {
  source           = "../sqs-to-lambda-event-source-mapping"
  queue            = aws_sqs_queue.dlq.arn
  lambda_arn       = module.lambda-sqs-to-s3.arn
  lambda_role_name = module.lambda-sqs-to-s3.role_name
}

module "dlq-sns-to-dlq-sqs" {
  source     = "../sns-to-sqs-subscriptions"
  subscriptions = {
    local = {
      topic = module.sns-dlq-topic.arn
      queue = aws_sqs_queue.dlq.arn
    }
  }
}