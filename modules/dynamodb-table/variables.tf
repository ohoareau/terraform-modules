variable "name" {
  type = "string"
}
variable "ttl" {
  type = "string"
  default = ""
}
variable "indexes" {
  type = "map"
  default = {}
}