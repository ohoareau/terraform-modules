variable "name" {
  type = string
}
variable "file" {
  type = string
}
variable "runtime" {
  type    = string
  default = "nodejs10.x"
}
variable "handler" {
  type    = string
  default = "index.handler"
}
variable "variables" {
  type    = "map"
  default = {}
}
variable "enabled" {
  type    = bool
  default = true
}
variable "policy_statements" {
  type = "list"
  default = []
}