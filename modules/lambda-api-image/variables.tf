variable "name" {
  type = string
}
variable "config_file" {
  type = string
  default = ""
}
variable "config_statics_file" {
  type = string
  default = ""
}
variable "health_file" {
  type = string
  default = ""
}
variable "robots_file" {
  type = string
  default = ""
}
variable "sitemap_file" {
  type = string
  default = ""
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