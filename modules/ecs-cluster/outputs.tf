output "arn" {
  value = (var.enabled && length(aws_ecs_cluster.cluster) > 0) ? aws_ecs_cluster.cluster[0].arn : null
}
output "id" {
  value = (var.enabled && length(aws_ecs_cluster.cluster) > 0) ? aws_ecs_cluster.cluster[0].id : null
}
output "name" {
  value = (var.enabled && length(aws_ecs_cluster.cluster) > 0) ? aws_ecs_cluster.cluster[0].name : null
}