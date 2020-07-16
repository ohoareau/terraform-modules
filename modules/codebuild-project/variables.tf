variable "env" {
  type    = string
  default = "dev"
}
variable "name" {
  type = string
}
variable "buildspec_file" {
  type = string
}
variable "image" {
  type = string
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
