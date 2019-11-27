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