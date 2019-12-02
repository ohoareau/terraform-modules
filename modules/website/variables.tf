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
variable "error_403_path" {
  type    = string
  default = "/403.html"
}
variable "error_404_path" {
  type    = string
  default = "/404.html"
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