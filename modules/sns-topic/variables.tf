variable "name" {
  type = string
}
variable "enabled" {
  type    = bool
  default = true
}
variable "sources" {
  type    = list(string)
  default = []
}