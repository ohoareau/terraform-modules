variable "name" {
  type = "string"
}
variable "file" {
  type = "string"
}
variable "runtime" {
  default = "nodejs10.x"
}
variable "handler" {
  default = "index.handler"
}
variable "variables" {
  type    = "map"
  default = {}
}
variable "enabled" {
  default = true
}
variable "policy_statements" {
  type = "list"
  default = []
}