variable "name" {
  type = string
}
variable "dev_attributes" {
  type    = map(any)
  default = {}
}
variable "email_identity" {
  type    = string
  default = ""
}
variable "verification_email_subject" {
  type    = string
  default = ""
}
variable "verification_email_message" {
  type    = string
  default = ""
}
variable "invite_email_subject" {
  type    = string
  default = ""
}
variable "invite_email_message" {
  type    = string
  default = ""
}
