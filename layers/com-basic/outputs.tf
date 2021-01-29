output "identities" {
  value = local.identities
}
output "smtp_user" {
  value       = local.smtp_user_infos
  sensitive   = true
  description = "Optional SES SMTP user credentials"
}