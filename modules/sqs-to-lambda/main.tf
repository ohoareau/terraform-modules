resource "aws_lambda_event_source_mapping" "queue-event-source-mapping" {
  batch_size        = 1
  event_source_arn  = aws_sqs_queue.queue.arn
  enabled           = true
  function_name     = var.lambda_arn
}

resource "aws_sqs_queue" "queue" {
  name = var.name
}

data "aws_iam_policy_document" "lambda-triggable-from-sqs" {
  statement {
    sid       = "AllowSQSPermissions"
    effect    = "Allow"
    resources = ["arn:aws:sqs:*"]
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
    ]
  }
}

resource "aws_iam_role_policy" "lambda-triggable-from-sqs" {
  policy = data.aws_iam_policy_document.lambda-triggable-from-sqs.json
  role = var.lambda_role_name
}
