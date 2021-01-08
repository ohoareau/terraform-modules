variable "env" {
  type = string
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
  default = null
}
variable "dns_support" {
  type    = bool
  default = null
}