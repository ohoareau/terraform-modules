data "aws_iam_policy_document" "sqs-queue" {
  statement {
    actions = [
      "sqs:SendMessage",
    ]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"

      values = [var.topic_arn]
    }
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    resources = [var.queue_arn]
  }
}

resource "aws_sqs_queue_policy" "queue" {
  queue_url = var.queue_id
  policy = data.aws_iam_policy_document.sqs-queue.json
}

resource "aws_sns_topic_subscription" "sns-to-sqs" {
  topic_arn = var.topic_arn
  protocol  = "sqs"
  endpoint  = var.queue_arn
}
