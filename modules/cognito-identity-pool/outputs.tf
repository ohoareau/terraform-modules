output "id" {
  value = aws_cognito_identity_pool.main.id
}
output "arn" {
  value = aws_cognito_identity_pool.main.arn
}
output "unauthenticated_role_id" {
  value = aws_iam_role.unauthenticated.id
}
output "authenticated_role_id" {
  value = aws_iam_role.authenticated.id
}