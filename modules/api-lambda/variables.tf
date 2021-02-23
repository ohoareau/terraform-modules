variable "name" {
  type = string
}
variable "env" {
  type = string
}
variable "lambda_arn" {
  type = string
}
variable "dns" {
  type = string
}
variable "dns_zone" {
  type = string
}
variable "geolocations" {
  type    = list(string)
  default = []
}
variable "price_class" {
  type    = string
  default = "PriceClass_100"
}
variable "forward_query_string" {
  type    = bool
  default = true
}
variable "allowed_methods" {
  type    = list(string)
  default = ["GET", "POST", "DELETE", "PUT", "PATCH", "HEAD", "OPTIONS"]
}
variable "cached_methods" {
  type    = list(string)
  default = ["GET", "HEAD"]
}