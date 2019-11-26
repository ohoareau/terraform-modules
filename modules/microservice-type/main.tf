locals {
  name_plural  = ("" != var.name_plural) ? var.name_plural : "${var.name}s"
  upper_name   = title(var.name)
  table_prefix = (var.parent != null) ? "${var.microservice.table_prefix}${replace(var.parent.full_name, "-", "_")}_${var.name}" : "${var.microservice.table_prefix}${var.name}"
}

locals {
  full_name              = (var.parent != null) ? "${var.parent.full_name}-${var.name}" : var.name
  full_name_plural       = (var.parent != null) ? "${var.parent.full_upper_name}${local.upper_name_plural}" : local.name_plural
  full_upper_name        = (var.parent != null) ? "${var.parent.full_upper_name}${local.upper_name}" : local.upper_name
  upper_name_plural      = title(local.name_plural)
  full_upper_name_plural = title(local.full_name_plural)
}

locals {
  prefix = "${var.microservice.prefix}-${local.full_name}"
}

module "dynamodb-table" {
  source     = "../dynamodb-table"
  name       = local.table_prefix
  attributes = var.table_attributes
  indexes    = var.table_indexes
}