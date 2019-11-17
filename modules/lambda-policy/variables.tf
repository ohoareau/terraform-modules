variable "name" {
  type = "string"
}
variable "role_name" {
  type = "string"
}
variable "actions" {
  type = "list"
  default = []
}
variable "resources" {
  type = "list"
  default = []
}
variable "statements" {
  type = "list"
  default = []
}
variable "policy_name" {
  default = "default"
}
variable "enabled" {
  default = true
}