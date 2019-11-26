locals {
  type = var.type ? var.type : (var.mode == "query" ? "Query" : (var.mode == "mutation" ? "Mutation" : "Query"))
}

resource "aws_appsync_resolver" "resolver" {
  count             = var.enabled ? 1 : 0
  api_id            = var.api
  field             = var.name
  type              = var.type
  data_source       = var.datasource
  request_template  = templatefile("${path.module}/files/${var.mode}-request.vm.tpl", {config: var.config, sourcePrefix: ("Query" == local.type) ? "" : "${lower(substr(local.type, 0, 1))}${substr(local.type, 1, length(local.type) - 1)}_"})
  response_template = templatefile("${path.module}/files/${var.mode}-response.vm.tpl", {config: var.config})
}
