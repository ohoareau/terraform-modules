data "archive_file" "lambda-code" {
  type        = "zip"
  output_path = var.package_file
  source_dir  = var.code_dir
  depends_on  = [
    local_file.file,
  ]
}

resource "local_file" "file" {
  for_each = local.files
  content  = file("" != each.value[1] ? each.value[1] : "${path.module}/${each.value[2]}")
  filename = "${var.code_dir}/${each.value[0]}"
}

module "lambda" {
  source            = "../lambda"
  name              = var.name
  file              = data.archive_file.lambda-code.output_path
  file_hash         = data.archive_file.lambda-code.output_base64sha256
  runtime           = var.runtime
  timeout           = var.timeout
  memory_size       = var.memory_size
  handler           = var.handler
  variables         = var.variables
  publish           = null == var.publish ? false : var.publish
  policy_statements = var.policy_statements
  providers = {
    aws = aws
  }
  depends_on = [
    data.archive_file.lambda-code
  ]
}