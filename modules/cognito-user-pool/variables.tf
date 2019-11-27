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
variable "email_subject" {
  type    = string
  default = ""
}
variable "email_message" {
  type    = string
  default = ""
}
