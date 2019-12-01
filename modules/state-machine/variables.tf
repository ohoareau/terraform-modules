variable "name" {
  type = string
}
variable "enabled" {
  type    = bool
  default = true
}
variable "definition" {
  type = string
}
variable "policy_statements" {
  type = list(object({
    actions = list(string),
    resources = list(string),
    effect = string
  }))
  default = []
}