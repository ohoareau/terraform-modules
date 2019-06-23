resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = var.name
  allow_unauthenticated_identities = true
# Open BUG : https://github.com/terraform-providers/terraform-provider-aws/issues/5704 => need to change 'name' and will create a new (no problem on create)
  cognito_identity_providers {
    client_id               = var.user_pool_client_id
    provider_name           = "cognito-idp.${var.user_pool_region}.amazonaws.com/${var.user_pool_id}"
    server_side_token_check = true
  }
  supported_login_providers        = var.login_providers
}
resource "aws_iam_role" "authenticated" {
  name = "cognito_id_pool_authenticated_${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.main.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}
resource "aws_iam_role" "unauthenticated" {
  name = "cognito_id_pool_unauthenticated_${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.main.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_cognito_identity_pool_roles_attachment" "pool" {
  identity_pool_id = aws_cognito_identity_pool.main.id

  roles = {
    "authenticated"   = aws_iam_role.authenticated.arn
    "unauthenticated" = aws_iam_role.unauthenticated.arn
  }
}