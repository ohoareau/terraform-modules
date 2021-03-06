resource "aws_sqs_queue" "queue" {
  name                       = var.name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  fifo_queue                 = var.fifo_queue
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
