variable "env" {
  type    = string
  default = "dev"
}
variable "name" {
  type = string
}
variable "compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
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
variable "variables" {
  type    = map(string)
  default = {}
}
variable "build_timeout" {
  type    = number
  default = 5
}
variable "queued_timeout" {
  type    = number
  default = 5
}