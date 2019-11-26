module "sns-outgoing-topic-policy" {
  source  = "../sns-topic-policy"
  topic   = var.microservice.sns_topics.outgoing.arn
  sources = [for o in var.operations : lookup(o, "lambda_arn", "")]
}

module "sqs-incoming-queue-event-source-mapping" {
  source = "../sqs-to-lambda-event-source-mapping"
  queue = var.microservice.sqs_queues.incoming.arn
  lambda_arn = var.microservice.lambdas.events.arn
  lambda_role_name = var.microservice.lambdas.events.role_name
}

data "aws_iam_policy_document" "appsync_api_role" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [for o in var.operations : lookup(o, "lambda_arn", "")]
  }
}

resource "aws_iam_role_policy" "appsync_api_main_policy" {
  name = "appsync_api_${var.microservice.prefix}_main_policy"
  role = var.microservice.apis.main.assume_role
  policy = data.aws_iam_policy_document.appsync_api_role.json
}

resource "aws_iam_role_policy" "appsync_api_public_policy" {
  name = "appsync_api_${var.microservice.prefix}_public_policy"
  role = var.microservice.apis.public.assume_role
  policy = data.aws_iam_policy_document.appsync_api_role.json
}

