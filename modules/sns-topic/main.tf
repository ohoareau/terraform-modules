resource "aws_sns_topic" "topic" {
  name = var.name
}

module "policy" {
  enabled = length(var.sources) > 0
  source  = "../sns-topic-policy"
  sources = var.sources
  topic   = aws_sns_topic.topic.arn
}