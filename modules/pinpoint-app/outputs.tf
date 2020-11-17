output "application_id" {
  value = aws_pinpoint_app.app.application_id
}
output "arn" {
  value = aws_pinpoint_app.app.arn
}
output "role_arn" {
  value = aws_iam_role.app.arn
}
output "role_name" {
  value = aws_iam_role.app.name
}