variable "name" {
  type = string
}
variable "protocol" {
  type    = string
  default = "HTTP"
}
variable "lambda_arn" {
  type = string
}