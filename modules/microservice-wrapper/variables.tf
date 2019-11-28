variable "microservice" {
  type = object({
    env = string,
    file = string,
    table_prefix = string,
    prefix = string,
    name = string,
    apis = map(
    object({
      id = string,
      assume_role_arn = string,
      assume_role = string,
    }),
    ),
    sns_topics = map(
    object({
      arn = string,
    })
    ),
    sqs_queues = map(object({
      arn = string,
    })),
    variables = map(string),
    dynamodb_tables = map(
    object({
      arn = string,
    })
    ),
  })
}
variable "operations" {
  type    = list(object({
    lambda_arn = string,
    local_name = string,
  }))
  default = []
}
variable "types" {
  type    = list(object({
  }))
  default = []
}
variable "events_variables" {
  type    = map(string)
  default = {}
}
variable "events_policy_statements" {
  type = list(object({
    actions = list(string),
    resources = list(string),
    effect = string,
  }))
  default = []
}
variable "migrate_variables" {
  type    = map(string)
  default = {}
}
variable "migrate_policy_statements" {
  type = list(object({
    actions = list(string),
    resources = list(string),
    effect = string,
  }))
  default = []
}
