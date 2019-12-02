variable "enabled" {
  type    = bool
  default = true
}
variable "api" {
  type = string
}
variable "type" {
  type    = string
  default = ""
}
variable "mode" {
  type    = string
  default = "query"
}
variable "name" {
  type = string
}
variable "datasource" {
  type = string
}
variable "config" {
  type    = map(string)
  default = {}
}
