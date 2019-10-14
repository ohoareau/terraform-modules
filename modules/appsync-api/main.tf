data "local_file" "schema" {
  filename = var.schema_file
}
resource "aws_appsync_graphql_api" "api" {
  authentication_type = var.auth_type
  name                = var.name
  schema              = data.local_file.schema.content
  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.logs.arn
    field_log_level          = "ERROR"
  }
  dynamic "user_pool_config" {
    iterator = v
    for_each = ("" == var.user_pool_id) ? {} : {user_pool: true}
    content {
      aws_region     = var.user_pool_region
      default_action = "DENY"
      user_pool_id   = var.user_pool_id
    }
  }
}

resource "aws_iam_role" "logs" {
  name = "appsync-api-${var.name}-logs-role"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "appsync.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  role       = aws_iam_role.logs.name
}