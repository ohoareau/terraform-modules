resource "aws_sqs_queue" "queue" {
  name = var.name
}

module "lambda-event-source-mapping" {
  enabled          = "" != var.lambda_arn
  source           = "../sqs-to-lambda-event-source-mapping"
  queue            = aws_sqs_queue.queue.arn
  lambda_arn       = var.lambda_arn
  lambda_role_name = var.lambda_role_name
}