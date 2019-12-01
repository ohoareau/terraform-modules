output "arn" {
  value = var.enabled ? aws_sfn_state_machine.sfn[0].id : null
}