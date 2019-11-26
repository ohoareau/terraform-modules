resource "aws_lambda_event_source_mapping" "queue-event-source-mapping" {
  count             = var.enabled ? 1 : 0
  batch_size        = 1
  event_source_arn  = var.queue
  enabled           = true
  function_name     = var.lambda_arn
}

data "aws_iam_policy_document" "lambda-triggable-from-sqs" {
  count = var.enabled ? 1 : 0
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
  count  = var.enabled ? 1 : 0
  policy = var.enabled ? data.aws_iam_policy_document.lambda-triggable-from-sqs.json : null
  role   = var.lambda_role_name
}