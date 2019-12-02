variable "zone" {
  type = string
}
variable "ttl" {
  type    = number
  default = 3600
}
variable "dkim_ttl" {
  type    = number
  default = 1800
}
variable "verification_id" {
  type    = string
  default = ""
}
variable "dkim_verification_id_01" {
  type    = string
  default = ""
}
variable "dkim_verification_id_02" {
  type    = string
  default = ""
}
variable "dkim_verification_id_03" {
  type    = string
  default = ""
}
