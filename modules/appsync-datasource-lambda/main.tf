resource "aws_appsync_datasource" "lambda" {
  api_id           = var.api
  name             = replace(var.name, "-", "_")
  type             = "AWS_LAMBDA"
  service_role_arn = aws_iam_role.appsync_api.arn

  lambda_config {
    function_arn = var.lambda_arn
  }
}

resource "aws_iam_role" "appsync_api" {
  name = "appsync_api_${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "appsync_api_policy" {
  name = "appsync_api_${var.name}_policy"
  role = aws_iam_role.appsync_api.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": ["${var.lambda_arn}"]
    }
  ]
}
EOF
}
