variable "env" {
  type = string
}
variable "bucket_name" {
  type = string
}
variable "bucket_key_prefix" {
  type    = string
  default = ""
}
variable "create_bucket" {
  type    = bool
  default = true
}