variable "zone" {
  type = "string"
}
variable "mx_ttl" {
  default = 3600
}
variable "dkim_ttl" {
  default = 3600
}
variable "site_verification_ttl" {
  default = 300
}
variable "mx_verification_id" {
  default = ""
}
variable "dkim_verification_id" {
  default = ""
}
variable "site_verification_id" {
  default = ""
}
