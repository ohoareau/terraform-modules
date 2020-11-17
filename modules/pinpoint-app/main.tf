resource "aws_pinpoint_email_channel" "email" {
  for_each       = toset(var.email_channels)
  application_id = aws_pinpoint_app.app.application_id
  from_address   = each.value.from
  identity       = each.value.identity
  role_arn       = aws_iam_role.app.arn
}

resource "aws_pinpoint_sms_channel" "sms" {
  for_each = toset(var.sms_channels)
  application_id = aws_pinpoint_app.app.application_id
  sender_id = each.value.sender
  short_code = each.value.short_code
}

resource "aws_pinpoint_apns_channel" "apns" {
  for_each = toset(var.apns_channels)
  application_id = aws_pinpoint_app.app.application_id
  certificate = each.value.certificate
  private_key = each.value.private_key
  bundle_id = each.value.bundle_id
  team_id = each.value.team_id
  token_key = each.value.token_key
  token_key_id = each.value.token_key_id
}

resource "aws_pinpoint_apns_sandbox_channel" "apns_sandbox" {
  for_each = toset(var.apns_sandbox_channels)
  application_id = aws_pinpoint_app.app.application_id
  certificate = each.value.certificate
  private_key = each.value.private_key
  bundle_id = each.value.bundle_id
  team_id = each.value.team_id
  token_key = each.value.token_key
  token_key_id = each.value.token_key_id
}

resource "aws_pinpoint_apns_voip_channel" "apns_voip" {
  for_each = toset(var.apns_voip_channels)
  application_id = aws_pinpoint_app.app.application_id
  certificate = each.value.certificate
  private_key = each.value.private_key
  bundle_id = each.value.bundle_id
  team_id = each.value.team_id
  token_key = each.value.token_key
  token_key_id = each.value.token_key_id
}

resource "aws_pinpoint_apns_voip_sandbox_channel" "apns_voip_sandbox" {
  for_each = toset(var.apns_voip_sandbox_channels)
  application_id = aws_pinpoint_app.app.application_id
  certificate = each.value.certificate
  private_key = each.value.private_key
  bundle_id = each.value.bundle_id
  team_id = each.value.team_id
  token_key = each.value.token_key
  token_key_id = each.value.token_key_id
}

resource "aws_pinpoint_baidu_channel" "baidu" {
  for_each       = toset(var.baidu_channels)
  application_id = aws_pinpoint_app.app.application_id
  enabled        = true
  api_key        = each.value.api_key
  secret_key     = each.value.secret_key
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
