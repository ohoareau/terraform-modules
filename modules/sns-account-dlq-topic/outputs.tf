output "arn" {
  value = module.sns-dlq-topic.arn
}
output "id" {
  value = module.sns-dlq-topic.id
}
output "name" {
  value = local.name
}