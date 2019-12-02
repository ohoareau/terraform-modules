variable "name" {
  type = string
}
variable "schema_file" {
  type = string
}
variable "auth_type" {
  type    = string
  default = "AWS_IAM"
}
variable "user_pool_region" {
  type    = string
  default = ""
}
variable "user_pool_id" {
  type    = string
  default = ""
}