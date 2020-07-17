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
          var.pipeline_bucket,
          "${var.pipeline_bucket}/*"
        ]
        effect    = "Allow"
      },
    ],
    var.policy_statements
  )
}

data "aws_iam_policy_document" "policy" {
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

resource "aws_iam_role_policy" "policy" {
  role   = var.role_name
  policy = data.aws_iam_policy_document.policy.json
}
