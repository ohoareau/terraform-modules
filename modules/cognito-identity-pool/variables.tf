variable "name" {
  type = string
}
variable "login_providers" {
  type = map(any)
  default = {}
}
variable "user_pool_id" {
  type = string
}
variable "user_pool_region" {
  type = string
}
variable "user_pool_client_id" {
  type = string
}
