output "service_id" {
  value = (var.enabled && length(aws_ecs_service.service) > 0) ? aws_ecs_service.service[0].id : null
}
output "service_name" {
  value = (var.enabled && length(aws_ecs_service.service) > 0) ? aws_ecs_service.service[0].name : null
}
output "task_arn" {
  value = (var.enabled && length(aws_ecs_task_definition.task) > 0) ? aws_ecs_task_definition.task[0].arn : null
}
output "task_id" {
  value = (var.enabled && length(aws_ecs_task_definition.task) > 0) ? aws_ecs_task_definition.task[0].id : null
}