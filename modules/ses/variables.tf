variable "name" {
  type = string
}
variable "dns" {
  type = string
}
variable "zone" {
  type = string
}
variable "emails" {
  type    = map(string)
  default = {}
}
variable "sources" {
  type    = list(string)
  default = []
}