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
variable "cors_config" {
  type    = object({
    allow_origins = string
    allow_credentials = string
    expose_headers = string
    max_age = string
    allow_methods = string
    allow_headers = string
  })
}