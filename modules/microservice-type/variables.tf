variable "microservice" {
  type = object({
    env = string,
    debug = bool,
    file = string,
    name = string,
    prefix = string,
    variables = map(string),
  })
}
variable "parent" {
  type = object({
    full_name       = string,
    upper_name      = string,
    full_upper_name = string,
  })
  default = null
}
variable "name" {
  type = string
}
variable "name_plural" {
  type    = string
  default = ""
}
variable "table_attributes" {
  type = map(
    object({
      type = string
    })
  )
  default = {id = {type: "S"}}
}
variable "table_indexes" {
  type = map(
    object({
      type = string
    })
  )
  default = {}
}