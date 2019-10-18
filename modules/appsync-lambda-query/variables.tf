variable "name" {
  type = "string"
}
variable "api" {
  type = "string"
}
variable "lambda_arn" {
  type = "string"
}
variable "api_name" {
  default = ""
}
variable "type" {
  default = "Query"
}