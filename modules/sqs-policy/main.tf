data "aws_iam_policy_document" "queue" {
  statement {
    actions = ["sqs:SendMessage"]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = var.sources
    }
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    resources = [var.arn]
  }
}

resource "aws_sqs_queue_policy" "queue" {
  queue_url = var.id
  policy = data.aws_iam_policy_document.queue.json
}