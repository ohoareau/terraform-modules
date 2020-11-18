output "id" {
  value = aws_ses_domain_identity.identity.id
}
output "arn" {
  value = aws_ses_domain_identity.identity.arn
}
output "verification_token" {
  value = aws_ses_domain_identity.identity.verification_token
}
output "domain" {
  value = aws_ses_domain_identity.identity.domain
}
output "email_identities" {
  value = {for k,v in aws_ses_email_identity.identities: k => {arn: v.arn, email: "${var.emails[k]}@${var.domain}"}}
}
output "region" {
  value = local.region
}