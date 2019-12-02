variable "zone" {
  type = string
}
variable "id_01" {
  type    = string
  default = ""
}
variable "id_02" {
  type    = string
  default = ""
}
variable "id_03" {
  type    = string
  default = ""
}
variable "value_03" {
  type    = string
  default = ""
}
variable "ttl" {
  type    = number
  default = 3600
}
variable "dkim_verification_id_01" {
  type    = string
  default = ""
}
variable "dkim_verification_id_02" {
  type    = string
  default = ""
}
variable "dkim_ttl" {
  type    = number
  default = 3600
}
variable "dedicated_ip_01" {
  type    = string
  default = ""
}
variable "dedicated_ip_01_name" {
  type    = string
  default = ""
}
variable "dedicated_ip_ttl" {
  type    = number
  default = 300
}
