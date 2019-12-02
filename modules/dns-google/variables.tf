variable "zone" {
  type = string
}
variable "mx_ttl" {
  type    = number
  default = 3600
}
variable "dkim_ttl" {
  type    = number
  default = 3600
}
variable "site_verification_ttl" {
  type    = number
  default = 300
}
variable "mx_verification_id" {
  type    = string
  default = ""
}
variable "dkim_verification_id" {
  type    = string
  default = ""
}
variable "site_verification_id" {
  type    = string
  default = ""
}
