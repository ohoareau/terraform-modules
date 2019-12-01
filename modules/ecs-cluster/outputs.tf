output "arn" {
  value = var.enabled ? aws_ecs_cluster.cluster[0].arn : null
}
output "id" {
  value = var.enabled ? aws_ecs_cluster.cluster[0].id : null
}
output "name" {
  value = var.enabled ? aws_ecs_cluster.cluster[0].name : null
}