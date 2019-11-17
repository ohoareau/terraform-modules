variable "name" {
  type = string
}
variable "role_name" {
  type = string
}
variable "actions" {
  type    = list(string)
  default = []
}
variable "resources" {
  type    = list(string)
  default = []
}
variable "statements" {
  type    = "list"
  default = []
}
variable "policy_name" {
  type    = string
  default = "default"
}
variable "enabled" {
  type    = bool
  default = true
}