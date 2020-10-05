variable "name" {
  type = string
}
variable "package_file" {
  type = string
}
variable "runtime" {
  type    = string
  default = "provided.al2"
}
variable "timeout" {
  type    = number
  default = 60
}
variable "memory_size" {
  type    = number
  default = 512
}
variable "handler" {
  type    = string
  default = "web/app.php"
}
variable "variables" {
  type    = map(string)
  default = {}
}
variable "enabled" {
  type    = bool
  default = true
}
variable "policy_statements" {
  type = list(
  object({
    actions   = list(string),
    resources = list(string),
    effect    = string
  })
  )
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "layers" {
  type = list(string)
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "security_group_ids" {
  type    = list(string)
  default = []
}