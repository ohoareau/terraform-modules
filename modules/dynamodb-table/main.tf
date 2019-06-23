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
}
