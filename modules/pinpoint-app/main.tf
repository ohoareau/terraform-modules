resource "aws_pinpoint_email_channel" "email" {
  count          = null != var.email ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  from_address   = var.email.from
  identity       = var.email.identity
  role_arn       = aws_iam_role.app.arn
}

resource "aws_pinpoint_sms_channel" "sms" {
  count          = null != var.sms ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  sender_id      = var.sms.sender
  short_code     = var.sms.short_code
}

resource "aws_pinpoint_apns_channel" "apns" {
  count          = null != var.apns ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  certificate    = var.apns.certificate
  private_key    = var.apns.private_key
  bundle_id      = var.apns.bundle_id
  team_id        = var.apns.team_id
  token_key      = var.apns.token_key
  token_key_id   = var.apns.token_key_id
}

resource "aws_pinpoint_apns_sandbox_channel" "apns_sandbox" {
  count          = null != var.apns_sandbox ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  certificate    = var.apns_sandbox.certificate
  private_key    = var.apns_sandbox.private_key
  bundle_id      = var.apns_sandbox.bundle_id
  team_id        = var.apns_sandbox.team_id
  token_key      = var.apns_sandbox.token_key
  token_key_id   = var.apns_sandbox.token_key_id
}

resource "aws_pinpoint_apns_voip_channel" "apns_voip" {
  count          = null != var.apns_voip ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  certificate    = var.apns_voip.certificate
  private_key    = var.apns_voip.private_key
  bundle_id      = var.apns_voip.bundle_id
  team_id        = var.apns_voip.team_id
  token_key      = var.apns_voip.token_key
  token_key_id   = var.apns_voip.token_key_id
}

resource "aws_pinpoint_apns_voip_sandbox_channel" "apns_voip_sandbox" {
  count          = null != var.apns_voip_sandbox ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  certificate    = var.apns_voip_sandbox.certificate
  private_key    = var.apns_voip_sandbox.private_key
  bundle_id      = var.apns_voip_sandbox.bundle_id
  team_id        = var.apns_voip_sandbox.team_id
  token_key      = var.apns_voip_sandbox.token_key
  token_key_id   = var.apns_voip_sandbox.token_key_id
}

resource "aws_pinpoint_baidu_channel" "baidu" {
  count          = null != var.baidu ? 1 : 0
  application_id = aws_pinpoint_app.app.application_id
  enabled        = true
  api_key        = var.baidu.api_key
  secret_key     = var.baidu.secret_key
}

resource "aws_pinpoint_app" "app" {
  name = var.name
}

data "aws_iam_policy_document" "app-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = concat(
        ["pinpoint.amazonaws.com"],
        var.assume_role_identifiers
      )
    }
  }
}

resource "aws_iam_role" "app" {
  name               = (64 < length("pinpoint-app-${var.name}-role")) ? null : "pinpoint-app-${var.name}-role"
  name_prefix        = (64 >= length("pinpoint-app-${var.name}-role")) ? null : "pinpoint-app-role-"
  assume_role_policy = data.aws_iam_policy_document.app-assume-role.json
}

module "policy" {
  source = "../iam-policy"
  role_name = aws_iam_role.app.id
  statements = [
    {
      effect  = "Allow"
      actions = [
        "mobileanalytics:PutEvents",
        "mobileanalytics:PutItems"
      ]
      resources = [
        "*"
      ]
    }
  ]
}
