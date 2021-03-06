data "archive_file" "lambda-code" {
  type        = "zip"
  output_path = "${path.module}/lambda-code.zip"
  source {
    content  = file("${path.module}/code/index.js")
    filename = "index.js"
  }
  source {
    content  = file("${path.module}/code/utils.js")
    filename = "utils.js"
  }
  source {
    content  = file(("" == var.config_file) ? "${path.module}/code/config.js" : var.config_file)
    filename = "config.js"
  }
}

provider "aws" {
  alias = "central"
  region = "us-east-1"
}

module "lambda" {
  source            = "../lambda"
  name              = var.name
  file              = data.archive_file.lambda-code.output_path
  runtime           = var.runtime
  timeout           = var.timeout
  memory_size       = var.memory_size
  handler           = var.handler
  variables         = var.variables
  publish           = true
  assume_role_identifiers = ["edgelambda.amazonaws.com"]
  policy_statements = concat(
    [
      {
        effect    = "Allow"
        resources = ["arn:aws:logs:*:*:*"]
        actions   = ["logs:CreateLogGroup"]
      }
    ],
    var.policy_statements
  )
  providers = {
    aws = aws.central
  }
}