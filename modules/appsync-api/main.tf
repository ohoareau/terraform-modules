data "local_file" "schema" {
  filename = var.schema_file
}
resource "aws_appsync_graphql_api" "api" {
  authentication_type = "${var.auth_type}"
  name                = var.name
  schema              = data.local_file.schema.content
  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.logs.arn
    field_log_level          = "ERROR"
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