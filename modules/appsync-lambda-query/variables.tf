variable "name" {
  type = string
}
variable "api" {
  type = string
}
variable "lambda_arn" {
  type = string
}
variable "api_name" {
  type    = string
  default = ""
}
variable "type" {
  type    = string
  default = "Query"
}