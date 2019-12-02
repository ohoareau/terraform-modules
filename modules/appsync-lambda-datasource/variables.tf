variable "enabled" {
  type    = bool
  default = true
}
variable "api" {
  type = string
}
variable "name" {
  type = string
}
variable "api_assume_role_arn" {
  type = string
}
variable "lambda_arn" {
  type = string
}