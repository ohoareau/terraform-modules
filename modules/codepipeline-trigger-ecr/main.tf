data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

locals {
  prefix           = "${var.env}-${var.pipeline_name}-${var.ecr_name}-${var.ecr_tag}-trigger-ecr"
  role_name        = "pipeline-${local.prefix}-role"
  role_name_prefix = "pipeline-trigger-ecr-"
}

resource "aws_iam_role" "role" {
  name        = (128 < length(local.role_name)) ? null : local.role_name
  name_prefix = (128 >= length(local.role_name)) ? null : local.role_name_prefix
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

module "policy" {
  source      = "../iam-policy"
  name        = local.role_name
  name_prefix = local.role_name_prefix
  role_name   = aws_iam_role.role.name
  statements  = [
    {
      effect = "Allow"
      actions = ["codepipeline:StartPipelineExecution"]
      resources = [var.pipeline_arn]
    }
  ]
}

resource "aws_cloudwatch_event_rule" "ecr-push" {
  name          = local.prefix
  description   = "Capture ECR Push on ${var.ecr_name}:${var.ecr_tag} and trigger pipeline ${var.pipeline_name}"
  role_arn      = aws_iam_role.role.arn
  event_pattern = <<PATTERN
{
  "detail-type": ["ECR Image Action"],
  "source":      ["aws.ecr"],
  "detail":      {
    "action-type": ["PUSH"],
    "image-tag": ["${var.ecr_tag}"],
    "repository-name": ["${var.ecr_name}"],
    "result": ["SUCCESS"]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "trigger-pipeline" {
  target_id = "trigger-pipeline"
  arn       = var.pipeline_arn
  rule      = aws_cloudwatch_event_rule.ecr-push.name
}
