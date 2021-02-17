variable "name" {
  type = string
}
variable "file" {
  type = string
}
variable "file_hash" {
  type    = string
  default = null
}
variable "runtime" {
  type    = string
  default = "nodejs12.x"
}
variable "timeout" {
  type    = number
  default = 3
}
variable "memory_size" {
  type    = number
  default = 128
}
variable "handler" {
  type    = string
  default = "index.handler"
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
variable "dlq_sns_topic" {
  type    = string
  default = ""
}
variable "layers" {
  type    = list(string)
  default = []
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "security_group_ids" {
  type    = list(string)
  default = []
}
variable "assume_role_identifiers" {
  type    = list(string)
  default = []
}
variable "publish" {
  type    = bool
  default = false
}