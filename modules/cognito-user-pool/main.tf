resource "aws_cognito_user_pool" "pool" {
  name = var.name
  auto_verified_attributes = ["email"]

  dynamic "verification_message_template" {
    for_each = ("" == var.verification_email_subject && "" == var.verification_email_message) ? [] : [{subject: var.verification_email_subject, message: var.verification_email_message}]
    content {
      email_subject = lookup(verification_message_template.value, "subject", "")
      email_message = lookup(verification_message_template.value, "message", "")
    }
  }

  dynamic "admin_create_user_config" {
    for_each = ("" == var.invite_email_subject && "" == var.invite_email_message) ? [] : [{subject: var.invite_email_subject, message: var.invite_email_message}]
    content {
      invite_message_template {
        email_subject = lookup(admin_create_user_config.value, "subject", "")
        email_message = lookup(admin_create_user_config.value, "message", "")
      }
    }
  }
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
