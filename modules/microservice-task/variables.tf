variable "name" {
  type    = string
  default = ""
}
variable "enabled" {
  type    = bool
  default = true
}
variable "definition_vars" {
  type    = map(string)
  default = {}
}
variable "variables" {
  type    = map(string)
  default = {}
}
variable "definition_file" {
  type    = string
  default = ""
}
variable "tags" {
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
variable "image" {
  type = string
}
variable "cluster" {
  type    = string
  default = ""
}
variable "subnets" {
  type    = list(string)
  default = []
}
variable "security_groups" {
  type    = list(string)
  default = []
}
variable "microservice" {
  type = object({
    name = string,
    env = string,
    file = string,
    prefix = string,
    table_prefix = string,
    tasks_cluster = string,
    tasks_vpc_subnets = list(string)
    tasks_security_groups = list(string)
    apis = map(
    object({
      id = string,
      assume_role_arn = string,
    }),
    ),
    sns_topics = map(
    object({
      arn = string,
    })
    ),
    variables = map(string),
    dynamodb_tables = map(
    object({
      arn = string,
    })
    ),
  })
}
variable "entrypoint" {
  type    = list(string)
  default = []
}
variable "command" {
  type    = list(string)
  default = []
}