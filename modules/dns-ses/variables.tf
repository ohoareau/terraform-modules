variable "zone" {
  type = "string"
}
variable "ttl" {
  default = 3600
}
variable "dkim_ttl" {
  default = 1800
}
variable "verification_id" {
  default = ""
}
variable "dkim_verification_id_01" {
  default = ""
}
variable "dkim_verification_id_02" {
  default = ""
}
variable "dkim_verification_id_03" {
  default = ""
}
