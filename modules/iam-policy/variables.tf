variable "enabled" {
  type    = bool
  default = true
}
variable "name" {
  type = string
}
variable "name_prefix" {
  type    = string
  default = "policy-"
}
variable "role_name" {
  type = string
}
variable "statements" {
  type = list(
  object({
    actions   = list(string),
    resources = list(string),
    effect    = string
  })
  )
  default = []
}