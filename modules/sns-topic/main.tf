resource "aws_sns_topic" "topic" {
  name = var.name
}

data "aws_iam_policy_document" "sns-topic" {
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
    resources = [aws_sns_topic.topic.arn]
  }
}

resource "aws_sns_topic_policy" "topic" {
  arn = aws_sns_topic.topic.arn
  policy = data.aws_iam_policy_document.sns-topic.json
}
