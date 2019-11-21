variable "enabled" {
  type    = bool
  default = true
}
variable "api" {
  type = string
}
variable "api_name" {
  type = string
}
variable "queries" {
  type    = map(object({type: string, config: map(string)}))
  default = {}
}
variable "mutations" {
  type    = map(object({type: string, config: map(string)}))
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