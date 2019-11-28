variable "enabled" {
  type    = bool
  default = true
}
variable "name" {
  type = string
}
variable "hash_key" {
  type    = string
  default = "id"
}
variable "attributes" {
  default = {"id": {"type" = "S"}}
}
variable "ttl" {
  type    = string
  default = ""
}
variable "indexes" {
  type    = map(any)
  default = {}
}
variable "tags" {
  type    = map(string)
  default = {}
}