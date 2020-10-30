variable "name" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "zone" {
  type = string
}
variable "dns" {
  type = string
}
variable "index_document" {
  type    = string
  default = "index.html"
}
variable "error_document" {
  type    = string
  default = ""
}
# kept for compatibility, not used, use error_403_page_path instead
variable "error_403_path" {
  type    = string
  default = ""
}
variable "error_403_page_path" {
  type    = string
  default = ""
}
# kept for compatibility, not used, use error_404_page_path instead
variable "error_404_path" {
  type    = string
  default = ""
}
variable "error_404_page_path" {
  type    = string
  default = ""
}
variable "geolocations" {
  type    = list(string)
  default = ["FR", "BE", "LU", "IT", "ES", "CH", "NL", "GB", "PT", "MC"]
}
variable "price_class" {
  type    = string
  default = "PriceClass_100"
}
variable "apex_redirect" {
  type    = bool
  default = false
}
variable "bucket_cors" {
  type    = bool
  default = false
}
variable "forward_query_string" {
  type    = bool
  default = false
}
variable "lambdas" {
  type = list(object({
    event_type = string
    lambda_arn = string
    include_body = bool
  }))
}