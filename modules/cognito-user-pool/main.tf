resource "aws_cognito_user_pool" "pool" {
  name = var.name
  auto_verified_attributes = ["email"]
}
