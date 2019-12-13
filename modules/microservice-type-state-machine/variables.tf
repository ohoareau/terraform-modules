variable "name" {
  type = string
}
variable "enabled" {
  type    = bool
  default = true
}
variable "definition_file" {
  type    = string
  default = ""
}
variable "definition_vars" {
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
variable "variables" {
  type    = map(string)
  default = {}
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
      tasks_cluster = string,
      tasks_vpc_subnets = list(string)
      tasks_vpc_security_groups = list(string)
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