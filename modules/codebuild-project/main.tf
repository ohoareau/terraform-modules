locals {
  statements = concat(
    [
      {
        actions   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        resources = ["*"]
        effect    = "Allow"
      },
      {
        actions = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
        ],
        resources = ["*"],
        effect = "Allow"
      }
    ],
    var.policy_statements
  )
}

resource "aws_codebuild_project" "project" {
  name           = "${var.env}-${var.name}"
  description    = "${upper(var.env)} ${var.name}"
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout
  service_role   = aws_iam_role.role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"

    dynamic "environment_variable" {
      for_each = [for k,v in var.variables: {name: k, value: v}]
      content {
        name  = lookup(environment_variable.value, "name", null)
        value = lookup(environment_variable.value, "value", null)
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/${var.env}-${var.name}"
      stream_name = "main"
    }
  }

  source {
    type      = "NO_SOURCE"
    buildspec = file(var.buildspec_file)
  }
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "project" {
  dynamic "statement" {
    iterator = s
    for_each = local.statements
    content {
      actions   = lookup(s.value, "actions", [])
      resources = lookup(s.value, "resources", [])
      effect    = lookup(s.value, "effect", "Allow")
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "project-${var.env}-${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy" "policy" {
  role   = aws_iam_role.role.name
  policy = data.aws_iam_policy_document.project.json
}
