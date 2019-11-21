variable "id" {
  type = string
}
variable "arn" {
  type = string
}
variable "sources" {
  type    = list(string)
  default = []
}