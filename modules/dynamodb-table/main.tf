resource "aws_dynamodb_table" "table" {
  name           = var.name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
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
        hash_key           = v.value.hash_key ? v.value.hash_key : v.key
        range_key          = v.value.range_key ? v.value.range_key : null
        write_capacity     = v.value.write_capacity ? v.value.write_capacity : 10
        read_capacity      = v.value.read_capacity ? v.value.read_capacity : 10
        projection_type    = v.value.projection_type ? v.value.projection_type : "ALL"
        non_key_attributes = v.value.non_key_attributes ? v.value.non_key_attributes : null
    }
  }
}
