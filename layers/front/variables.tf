variable "name" {
  type    = string
  default = "front"
}
variable "bucket_name" {
  type = string
}
variable "geolocations" {
  type    = list(string)
  default = []
}
variable "dns" {
  type = string
}
variable "dns_zone" {
  type = string
}
