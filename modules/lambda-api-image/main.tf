data "archive_file" "lambda-code" {
  type        = "zip"
  output_path = "${path.module}/lambda-code.zip"
  source_dir  = "${path.module}/code"
  depends_on  = [
    local_file.config_js,
    local_file.config_statics_js,
    local_file.favicon_ico,
    local_file.health_json,
    local_file.robots_txt,
    local_file.sitemap_xml,
  ]
}

resource "local_file" "config_js" {
  content  = file("" != var.config_file ? var.config_file : "${path.module}/code/config.js")
  filename = "${path.module}/code/config.js"
}

resource "local_file" "config_statics_js" {
  content  = file("" != var.config_statics_file ? var.config_statics_file : "${path.module}/code/config-statics.js")
  filename = "${path.module}/code/config-statics.js"
}

resource "local_file" "favicon_ico" {
  content  = file("" != var.favicon_file ? var.favicon_file : "${path.module}/code/statics/favicon.ico")
  filename = "${path.module}/code/statics/favicon.ico"
}

resource "local_file" "health_json" {
  content  = file("" != var.health_file ? var.health_file : "${path.module}/code/statics/health.json")
  filename = "${path.module}/code/statics/health.json"
}

resource "local_file" "robots_txt" {
  content  = file("" != var.robots_file ? var.robots_file : "${path.module}/code/statics/robots.txt")
  filename = "${path.module}/code/statics/robots.txt"
}

resource "local_file" "sitemap_xml" {
  content  = file("" != var.sitemap_file ? var.sitemap_file : "${path.module}/code/statics/sitemap.xml")
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