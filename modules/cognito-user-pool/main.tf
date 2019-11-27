resource "aws_cognito_user_pool" "pool" {
  name = var.name
  auto_verified_attributes = ["email"]

  dynamic "email_configuration" {
    for_each = ("" == var.email_identity) ? [] : [{source_arn: var.email_identity}]
    content {
      email_sending_account = "DEVELOPER"
      source_arn = lookup(email_configuration.value, "source_arn", "")
    }
  }
  dynamic "schema" {
    iterator = v
    for_each = ("" == var.dev_attributes) ? {} : var.dev_attributes
    content {
      attribute_data_type = "String"
      developer_only_attribute = true
      mutable = true
      name = v.key
      required = v.value
    }
  }

}
