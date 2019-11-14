resource "aws_lambda_event_source_mapping" "queue-event-source-mapping" {
  batch_size        = 1
  event_source_arn  = aws_sqs_queue.queue.arn
  enabled           = true
  function_name     = var.lambda_arn
}

resource "aws_sqs_queue" "queue" {
  name = var.name
}
