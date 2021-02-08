data "archive_file" "lambda-code" {
  type        = "zip"
  output_path = "${path.module}/lambda-code.zip"
  source_dir  = "${path.module}/code"

  depends_on = concat(
    ("" == var.config_file) ? [] : [local_file.config_js],
    ("" == var.config_statics_file) ? [] : [local_file.config_statics_js],
    ("" == var.favicon_file) ? [] : [local_file.favicon_ico],
    ("" == var.health_file) ? [] : [local_file.health_json],
    ("" == var.robots_file) ? [] : [local_file.robots_txt],
    ("" == var.sitemap_file) ? [] : [local_file.sitemap_xml],
  )
}

resource "local_file" "config_js" {
  count    = "" == var.favicon_file ? 0 : 1
  content  = file(var.favicon_file)
  filename = "${path.module}/code/config.js"
}

resource "local_file" "config_statics_js" {
  count    = "" == var.config_statics_file ? 0 : 1
  content  = file(var.config_statics_file)
  filename = "${path.module}/code/config-statics.js"
}

resource "local_file" "favicon_ico" {
  count    = "" == var.favicon_file ? 0 : 1
  content  = file(var.favicon_file)
  filename = "${path.module}/code/statics/favicon.ico"
}

resource "local_file" "health_json" {
  count    = "" == var.health_file ? 0 : 1
  content  = file(var.health_file)
  filename = "${path.module}/code/statics/health.json"
}

resource "local_file" "robots_txt" {
  count    = "" == var.robots_file ? 0 : 1
  content  = file(var.robots_file)
  filename = "${path.module}/code/statics/robots.txt"
}

resource "local_file" "sitemap_xml" {
  count    = "" == var.sitemap_file ? 0 : 1
  content  = file(var.sitemap_file)
  filename = "${path.module}/code/statics/sitemap.xml"
}

provider "aws" {
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
  policy_statements = var.policy_statements
  providers = {
    aws = aws
  }
}