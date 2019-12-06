data "aws_iam_policy_document" "queue" {
  for_each = var.policies
  statement {
    actions = ["sqs:SendMessage"]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = each.value.sources
    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [each.value.arn]
  }
}

resource "aws_sqs_queue_policy" "queue" {
  for_each  = var.policies
  queue_url = each.value.id
  policy    = data.aws_iam_policy_document.queue[each.key].json
}