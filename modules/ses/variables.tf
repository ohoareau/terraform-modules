variable "name" {
  type = string
}
variable "domain" {
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