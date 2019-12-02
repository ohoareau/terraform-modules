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