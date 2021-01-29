output "identities" {
  value = local.identities
}
output "smtp_user" {
  value = (null != var.smtp_user_name)
    ? {
        name     = module.ses-smtp-user.name,
        arn      = module.ses-smtp-user.arn,
        password = module.ses-smtp-user.password,
        login    = module.ses-smtp-user.login
      }
    : null
  sensitive   = true
  description = "Optional SES SMTP user credentials"
}