output "email_identities" {
  value = {for k,v in aws_ses_email_identity.identities: k => {arn: v.arn, email: "${var.emails[k]}@${var.domain}"}}
}