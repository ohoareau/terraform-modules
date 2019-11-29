resource "aws_sns_topic" "topic" {
  count = var.enabled ? 1 : 0
  name  = var.name
}

module "policy" {
  enabled = var.enabled && (length(var.sources) > 0)
  source  = "../sns-topic-policy"
  sources = var.sources
  topic   = var.enabled ? aws_sns_topic.topic[0].arn : null
}