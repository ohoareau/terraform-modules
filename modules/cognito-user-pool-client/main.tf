resource "aws_cognito_user_pool_client" "client" {
  name            = var.name
  generate_secret = false
  user_pool_id    = var.user_pool
}