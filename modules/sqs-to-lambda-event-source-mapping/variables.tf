variable "enabled" {
  type    = bool
  default = true
}
variable "queue" {
  type = string
}
variable "lambda_arn" {
  type = string
}
variable "lambda_role_name" {
  type = string
}