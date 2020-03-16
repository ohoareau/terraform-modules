resource "aws_sns_topic_subscription" "sns-to-sqs" {
  for_each  = var.subscriptions
  topic_arn = each.value.topic
  protocol  = "sqs"
  endpoint  = each.value.queue
  filter_policy = ("" != each.value.filter) ? each.value.filter : null
}