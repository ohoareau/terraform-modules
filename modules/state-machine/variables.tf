variable "name" {
  type = string
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