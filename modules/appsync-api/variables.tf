variable "name" {
  type = "string"
}
variable "schema_file" {
  type = "string"
}
variable "auth_type" {
  default = "AWS_IAM"
}
variable "user_pool_region" {
  default = ""
}
variable "user_pool_id" {
  default = ""
}