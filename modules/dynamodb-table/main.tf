resource "aws_dynamodb_table" "table" {
  count          = var.enabled ? 1 : 0
  name           = var.name
  read_capacity  = ('PROVISION' == var.billing_mode) ? 1 : 0
  write_capacity = ('PROVISION' == var.billing_mode) ? 1 : 0
  hash_key       = var.hash_key
  range_key      = var.range_key
  tags           = var.tags
  billing_mode   = var.billing_mode

  dynamic "attribute" {
    iterator = v
    for_each = ("" == var.attributes) ? {} : var.attributes
    content {
      name = v.key
      type = lookup(v.value, "type", "S")
    }
  }
  dynamic "ttl" {
    iterator = v
    for_each = ("" == var.ttl) ? {} : {ttl: var.ttl}
    content {
        enabled = true
        attribute_name = v.value
    }
  }
  dynamic "global_secondary_index" {
    iterator = v
    for_each = ("" == var.indexes) ? {} : var.indexes
    content {
        name               = v.key
        hash_key           = lookup(v.value, "hash_key", v.key)
        range_key          = lookup(v.value, "range_key", null)
        write_capacity     = lookup(v.value, "write_capacity", 1)
        read_capacity      = lookup(v.value, "read_capacity", 1)
        projection_type    = lookup(v.value, "projection_type", "ALL")
        non_key_attributes = lookup(v.value, "non_key_attributes", null)
    }
  }
}