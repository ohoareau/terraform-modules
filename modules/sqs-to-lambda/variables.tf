variable "name" {
  type = string
}
variable "lambda_arn" {
  type    = string
  default = ""
}
variable "lambda_role_name" {
  type    = string
  default = ""
}