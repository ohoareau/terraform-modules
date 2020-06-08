variable "name" {
  type = string
}
variable "lambda_arn" {
  type = string
}
variable "stage" {
  type    = string
  default = "main"
}