resource "aws_ses_domain_identity_verification" "verification" {
  domain     = var.id
}
