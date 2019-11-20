variable "env" {
  type = string
}
variable "file" {
  type = string
}
variable "name" {
  type = string
}
variable "name_plural" {
  type    = string
  default = ""
}
variable "queues" {
  type = map(
    object({
      sources = list(string)
    })
  )
  default = {}
}
variable "enabled_operations" {
  type = map(bool)
  default = {}
}
variable "api_operations" {
  type = map(bool)
  default = {}
}
variable "operations" {
  type = map(
    object({
      variables = map(string),
      policy_statements = list(
        object({
          actions = list(string),
          resources = list(string),
          effect = string
        })
      )
    })
  )
  default = {}
}
variable "api_mutation_aliases" {
  type    = map(object({operation: string, config: map(string)}))
  default = {}
}
variable "api_query_aliases" {
  type    = map(object({operation: string, config: map(string)}))
  default = {}
}
variable "api" {
  type    = string
  default = ""
}
variable "api_name" {
  type    = string
  default = ""
}
variable "tables" {
  type = map(
    object({
      attributes = map(
        object({
          type = string
        })
      ),
      indexes = map(
        object({
          type = string
        })
      )
    })
  )
  default = {}
}