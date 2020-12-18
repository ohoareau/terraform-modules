resource "aws_sns_topic_subscription" "sns-to-http" {
  for_each  = var.subscriptions
  topic_arn = each.value.topic
  protocol  = "https"
  endpoint  = each.value.url
  endpoint_auto_confirms = true
  filter_policy = ("" != each.value.filter) ? each.value.filter : null
}