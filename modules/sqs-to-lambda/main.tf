resource "aws_sqs_queue" "queue" {
  name = var.name
}

data "aws_sqs_queue" "queue" {
  name       = var.name
  depends_on = [aws_sqs_queue.queue]
}

module "lambda-event-source-mapping" {
  source           = "../sqs-to-lambda-event-source-mapping"
  queue            = aws_sqs_queue.queue.arn
  lambda_arn       = var.lambda_arn
  lambda_role_name = var.lambda_role_name
}
