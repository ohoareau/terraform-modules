output "id" {
  value = aws_sqs_queue.queue.id
}
output "arn" {
  value = aws_sqs_queue.queue.arn
}
output "url" {
  value = data.aws_sqs_queue.queue.url
}