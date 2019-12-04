variable "env" {
  type = string
}
variable "debug" {
  type    = bool
  default = false
}
variable "file" {
  type = string
}
variable "name" {
  type = string
}
variable "api" {
  type    = string
  default = ""
}
variable "public_api" {
  type    = string
  default = ""
}
variable "api_name" {
  type    = string
  default = ""
}
variable "public_api_name" {
  type    = string
  default = ""
}
variable "tasks_vpc_subnets" {
  type    = list(string)
  default = []
}
variable "tasks_vpc_security_groups" {
  type    = list(string)
  default = []
}
variable "tasks_cluster" {
  type    = string
  default = ""
}
variable "buckets" {
  type = map(object({
    prefix = string,
    tags = map(string),
  }))
  default = {}
}
variable "dlq_sns_topic" {
  type    = string
  default = ""
}