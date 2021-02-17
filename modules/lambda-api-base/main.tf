data "archive_file" "lambda-code" {
  type        = "zip"
  output_path = var.package_file
  source_dir  = var.code_dir
  depends_on  = [
    local_file.config_js,
    local_file.config_statics_js,
    local_file.site_webmanifest,
    local_file.utils_js,
    local_file.root_json,
    local_file.healthz_json,
    local_file.robots_txt,
    local_file.sitemap_xml,
  ]
}

resource "local_file" "config_js" {
  content  = file("" != var.config_file ? var.config_file : "${path.module}/code/config.js")
  filename = "${var.code_dir}/config.js"
}

resource "local_file" "config_statics_js" {
  content  = file("" != var.config_statics_file ? var.config_statics_file : "${path.module}/code/config-statics.js")
  filename = "${var.code_dir}/config-statics.js"
}

resource "local_file" "utils_js" {
  content  = file("" != var.utils_file ? var.utils_file : "${path.module}/code/utils.js")
  filename = "${var.code_dir}/utils.js"
}

resource "local_file" "root_json" {
  content  = file("" != var.root_file ? var.root_file : "${path.module}/code/statics/root.json")
  filename = "${var.code_dir}/statics/root.json"
}

resource "local_file" "site_webmanifest" {
  content  = file("" != var.site_webmanifest_file ? var.site_webmanifest_file : "${path.module}/code/statics/site.webmanifest")
  filename = "${var.code_dir}/statics/site.webmanifest"
}

resource "local_file" "healthz_json" {
  content  = file("" != var.healthz_file ? var.healthz_file : "${path.module}/code/statics/healthz.json")
  filename = "${var.code_dir}/statics/healthz.json"
}

resource "local_file" "robots_txt" {
  content  = file("" != var.robots_file ? var.robots_file : "${path.module}/code/statics/robots.txt")
  filename = "${var.code_dir}/statics/robots.txt"
}

resource "local_file" "sitemap_xml" {
  content  = file("" != var.sitemap_file ? var.sitemap_file : "${path.module}/code/statics/sitemap.xml")
  filename = "${var.code_dir}/statics/sitemap.xml"
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
  publish           = var.publish
  policy_statements = var.policy_statements
  providers = {
    aws = aws
  }
  depends_on = [
    data.archive_file.lambda-code
  ]
}