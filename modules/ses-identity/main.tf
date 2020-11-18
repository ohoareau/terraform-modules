data "aws_region" "current" {}

locals {
  region      = data.aws_region.current.name
  need_policy = (0 < length(var.service_sources)) || (0 < length(var.sources))
}

resource "aws_ses_domain_identity" "identity" {
  domain = var.domain
}

resource "aws_route53_record" "verification_record" {
  zone_id = var.zone
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.identity.verification_token]
}

resource "aws_ses_domain_identity_verification" "verification" {
  domain     = aws_ses_domain_identity.identity.id
  depends_on = [aws_route53_record.verification_record]
}

resource "aws_ses_email_identity" "identities" {
  for_each = var.emails
  email = "${each.value}@${var.domain}"
}

resource "aws_ses_domain_mail_from" "domain" {
  domain           = aws_ses_domain_identity.identity.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.identity.domain}"
}

data "aws_iam_policy_document" "policy" {
  count = local.need_policy ? 1 : 0
  dynamic "statement" {
    for_each = (0 < length(var.sources)) ? [var.sources] : []
    content {
      actions   = [
        "ses:SendEmail",
        "ses:SendTemplatedEmail",
        "ses:SendRawEmail",
        "ses:SendBulkTemplatedEmail",
      ]
      resources = [aws_ses_domain_identity.identity.arn]
      condition {
        test = "ArnEquals"
        variable = "aws:SourceArn"
        values = statement.value
      }
      effect = "Allow"
      principals {
        type = "AWS"
        identifiers = ["*"]
      }
    }
  }
  dynamic "statement" {
    for_each = (0 < length(var.service_sources)) ? [var.service_sources] : []
    content {
      actions   = [
        "ses:SendEmail",
        "ses:SendTemplatedEmail",
        "ses:SendRawEmail",
        "ses:SendBulkTemplatedEmail",
      ]
      resources = [aws_ses_domain_identity.identity.arn]
      effect = "Allow"
      principals {
        type = "Service"
        identifiers = var.service_sources
      }
    }
  }
}

resource "aws_ses_identity_policy" "policy" {
  count    = local.need_policy ? 1 : 0
  identity = aws_ses_domain_identity.identity.arn
  name     = "${var.name}-policy"
  policy   = local.need_policy ? data.aws_iam_policy_document.policy[0].json : null
}