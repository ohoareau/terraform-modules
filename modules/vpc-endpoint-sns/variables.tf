variable "vpc_id" {
  type = string
}
variable "security_group_ids" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
}
variable "private_dns_enabled" {
  type    = bool
  default = false
}