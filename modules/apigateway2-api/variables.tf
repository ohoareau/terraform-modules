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
variable "cors" {
  type    = bool
  default = false
}
variable "cors_config" {
  type = object({
    allow_credentials = bool
    allow_headers     = list(string)
    allow_methods     = list(string)
    allow_origins     = list(string)
    expose_headers    = list(string)
    max_age           = number
  })
  default = {
    allow_credentials = false
    allow_headers     = ["*"]
    allow_methods     = ["*"]
    allow_origins     = ["*"]
    expose_headers    = []
    max_age           = 300
  }
}
