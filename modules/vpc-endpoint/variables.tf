variable "service" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "route_table_id" {
  type    = string
  default = null
}
variable "security_group_ids" {
  type    = list(string)
  default = []
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "private_dns_enabled" {
  type    = bool
  default = true
}