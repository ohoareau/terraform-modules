variable "name" {
  type    = string
  default = ""
}
variable "enabled" {
  type    = bool
  default = true
}
variable "family" {
  type = string
}
variable "handler" {
  type = string
}
variable "variables" {
  type    = map(string)
  default = {}
}
variable "timeout" {
  type    = number
  default = 10
}
variable "memory_size" {
  type    = number
  default = 256
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
}
variable "type" {
  type = object({
    name = string,
    full_name = string,
    prefix = string,
    full_upper_name = string,
    full_upper_name_plural = string,
    dynamodb-table = object({
      arn: string,
    }),
    microservice = object({
      env = string,
      name = string,
      file = string,
      prefix = string,
      table_prefix = string,
      dlq_sns_topic = string,
      registered_external_operations = map(object({
        variable: string,
        arn: string,
      })),
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
    }
  ))
  default = []
}
variable "required_external_operations" {
  type    = list(string)
  default = []
}