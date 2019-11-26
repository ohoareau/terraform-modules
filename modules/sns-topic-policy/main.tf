data "aws_iam_policy_document" "sns-topic" {
  count = var.enabled ? 1 : 0
  statement {
    actions = [
      "SNS:Publish",
    ]
    condition {
      test = "ArnLike"
      variable = "aws:SourceArn"
      values = var.sources
    }
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    resources = [var.topic]
  }
}

resource "aws_sns_topic_policy" "topic" {
  count  = var.enabled ? 1 : 0
  arn    = var.topic
  policy = var.enabled ? data.aws_iam_policy_document.sns-topic[0].json : null
}
