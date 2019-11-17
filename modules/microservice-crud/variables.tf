variable "env" {
  type = string
}
variable "file" {
  type = string
}
variable "name" {
  type = string
}
variable "name_plural" {
  type    = string
  default = ""
}
variable "operations" {
  type = "map"
  default = {}
}
variable "api" {
  type    = string
  default = ""
}
variable "api_name" {
  type    = string
  default = ""
}