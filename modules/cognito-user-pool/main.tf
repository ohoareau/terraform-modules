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
    for_each = ("" == var.invite_email_subject && "" == var.invite_email_message) ? [] : [{email_subject: var.invite_email_subject, email_message: var.invite_email_message, sms_message: var.invite_sms_message}]
    content {
      invite_message_template {
        email_subject = lookup(admin_create_user_config.value, "email_subject", "")
        email_message = lookup(admin_create_user_config.value, "email_message", "")
        sms_message = lookup(admin_create_user_config.value, "sms_message", "")
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
  dynamic "lambda_config" {
    for_each = var.post_triggers ? {x: true} : {}
    content {
      post_authentication = var.post_triggers ? module.lambda-post-triggers.arn : null
      post_confirmation   = var.post_triggers ? module.lambda-post-triggers.arn : null
    }
  }
}

data "archive_file" "lambda-post-triggers" {
  count       = var.post_triggers ? 1 : 0
  type        = "zip"
  output_path = "${path.module}/lambda-post-triggers.zip"
  source_dir  = "${path.module}/files/lambda-post-triggers"
}

module "lambda-post-triggers" {
  source      = "../lambda"
  enabled     = var.post_triggers
  file        = var.post_triggers ? data.archive_file.lambda-post-triggers[0].output_path : null
  name        = "${var.name}-post-triggers"
  handler     = "index.handler"
  variables   = {
      OUTGOING_TOPIC_ARN = var.post_triggers ? module.sns-outgoing-topic.arn : null
  }
  policy_statements = [
    {
      actions   = ["SNS:Publish"]
      resources = var.post_triggers ? [module.sns-outgoing-topic.arn] : []
      effect    = "Allow"
    },
  ]
}

module "sns-outgoing-topic" {
  source  = "../sns-topic"
  enabled = var.post_triggers
  name    = "${var.name}-outgoing"
  sources = var.post_triggers ? [module.lambda-post-triggers.arn] : []
}

resource "aws_lambda_permission" "allow_cognito" {
  count         = var.post_triggers ? 1 : 0
  statement_id  = "AllowExecutionFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda-post-triggers.name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.pool.arn
}