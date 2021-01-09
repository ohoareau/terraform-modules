variable "env" {
  type = string
}
variable "enabled" {
  type    = bool
  default = true
}
variable "cidr_block" {
  type = string
}
variable "subnets" {
  type    = map(object({
    public: bool,
    cidr_block: string
  }))
  default = {}
}
variable "security_groups" {
  type    = map(object({
    egress = list(object({
      from_port   = number,
      to_port     = number,
      protocol    = string,
      cidr_blocks = list(string),
    }))
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