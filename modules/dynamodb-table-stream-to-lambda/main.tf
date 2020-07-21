module "policy" {
  source      = "../iam-policy"
  name_prefix = "dynamodb-stream-"
  role_name   = var.lambda_role_name
  statements  = [
    {
      effect    = "Allow"
      actions   = [
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:ListStreams"
      ]
      resources = "${var.table_arn}/*"
    }
  ]
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn  = var.table_stream_arn
  enabled           = true
  function_name     = var.lambda_arn
  starting_position = "LATEST"
}