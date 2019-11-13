resource "aws_cognito_user_pool" "pool" {
  name = var.name
  auto_verified_attributes = ["email"]

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
