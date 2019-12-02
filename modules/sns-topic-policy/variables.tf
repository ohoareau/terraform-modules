variable "enabled" {
  type    = bool
  default = true
}
variable "topic" {
  type = string
}
variable "sources" {
  type = list(string)
}