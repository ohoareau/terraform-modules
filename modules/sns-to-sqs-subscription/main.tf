resource "aws_sns_topic_subscription" "sns-to-sqs" {
  topic_arn = var.topic_arn
  protocol  = "sqs"
  endpoint  = var.queue_arn
}
