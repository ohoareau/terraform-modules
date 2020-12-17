variable "env" {
  type = string
}
variable "dns" {
  type = string
}
variable "zone" {
  type = string
}
variable "identities" {
  type    = map(string)
  default = {}
}
variable "sources" {
  type    = list(string)
  default = []
}
variable "service_sources" {
  type    = list(string)
  default = []
}
