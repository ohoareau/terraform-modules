variable "name" {
  type    = string
  default = ""
}
variable "enabled" {
  type    = bool
  default = true
}
variable "variables" {
  type    = map(string)
  default = {}
}
variable "policy_statements" {
  type = list(object({
    actions = list(string),
    resources = list(string),
    effect = string,
  }))
  default = []
}
variable "type" {
  type = object({
    full_upper_name = string,
    full_upper_name_plural = string,
    dynamodb-table = object({arn = string}),
    microservice = object({
      env = string,
    }),
  })
}
variable "resolvers" {
  type = list(
  object({
    api = string,
    type = string,
    field = string,
    mode = string,
    config = map(string),
  })
  )
  default = []
}