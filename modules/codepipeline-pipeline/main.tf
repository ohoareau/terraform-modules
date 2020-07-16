locals {
  statements = concat(
    [
      {
        actions   = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObject"
        ]
        resources = [
          aws_s3_bucket.artifacts.arn,
          "${aws_s3_bucket.artifacts.arn}/*"
        ]
        effect    = "Allow"
      },
      {
        actions   = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ]
        resources = ["*"]
        effect    = "Allow"
      }
    ],
    var.policy_statements
  )
}

data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "pipeline" {
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
  name               = "project-${var.env}-${var.name}-pipeline-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_role_policy" "policy" {
  role   = aws_iam_role.role.name
  policy = data.aws_iam_policy_document.pipeline.json
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.env}-${var.name}-artifacts"
}

resource "aws_codepipeline" "pipeline" {
  name     = "${var.env}-${var.name}"
  role_arn = aws_iam_role.role.arn

  artifact_store {
    location = aws_s3_bucket.artifacts.id
    type     = "S3"
  }

  dynamic "stage" {
    for_each = var.stages
    content {
      name = stage.value.name
      action {
        name             = stage.value.name
        category         = stage.value.type
        configuration    = stage.value.config
        owner            = "AWS"
        provider         = stage.value.provider
        run_order        = stage.key + 1
        version          = "1"
        input_artifacts  = stage.value.inputs
        output_artifacts = stage.value.outputs
      }
    }
  }
}