variable "api" {
  type = string
}
variable "api_name" {
  type = string
}
variable "queries" {
  type = "map"
  default = {}
}
variable "mutations" {
  type = "map"
  default = {}
}
variable "name" {
  type = string
}
variable "datasources" {
  type = map(string)
  default = {}
}
variable "lambdas" {
  type = list(string)
  default = []
}