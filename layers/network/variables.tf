variable "env" {
  type = string
}
variable "name" {
  type    = string
  default = "network"
}
variable "cidr_block" {
  type = string
}
variable "subnets" {
  type    = map(object({
    public: bool,
    cidr_block: string
    availability_zone: string
  }))
  default = {}
}
variable "dns_hostnames" {
  type    = bool
  default = true
}
variable "dns_support" {
  type    = bool
  default = true
}
variable "security_group" {
  type    = bool
  default = false
}