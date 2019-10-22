variable "name" {
  type = "string"
}
variable "hash_key" {
  default = "id"
}
variable "attributes" {
  default = {"id": {"type" = "S"}}
}
variable "ttl" {
  type = "string"
  default = ""
}
variable "indexes" {
  type = "map"
  default = {}
}