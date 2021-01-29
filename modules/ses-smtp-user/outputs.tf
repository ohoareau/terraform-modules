output "name" {
  value       = aws_iam_user.user.name
  description = "IAM user name"
}

output "arn" {
  value       = aws_iam_user.user.arn
  description = "ARN of the IAM user"
}

output "login" {
  value       = aws_iam_access_key.user.id
  description = "IAM Access Key of the created user, used as the SMTP user name"
}

output "password" {
  value       = aws_iam_access_key.user.ses_smtp_password_v4
  description = "The secret access key converted into an SES SMTP password"
  sensitive   = true
}
