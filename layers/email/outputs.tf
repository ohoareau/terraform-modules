output "identity" {
  value = module.ses.identity
}
output "identity_arn" {
  value = module.ses.identity_arn
}
output "verification_token" {
  value = module.ses.verification_token
}
output "domain" {
  value = module.ses.domain
}
output "email_identities" {
  value = module.ses.email_identities
}