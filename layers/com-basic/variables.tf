variable "env" {
  type = string
}
variable "dns" {
  type = string
}
variable "zone" {
  type = string
}
variable "identities" {
  type    = map(string)
  default = {}
}
variable "sources" {
  type    = list(string)
  default = []
}
variable "service_sources" {
  type    = list(string)
  default = []
}
variable "smtp_user_name" {
  type        = string
  default     = null
  description = "Name of the optional IAM User to create and for which to enable SES SMTP access"
}