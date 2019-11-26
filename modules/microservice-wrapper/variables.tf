variable "microservice" {
  type = object({
    env = string,
    file = string,
    table_prefix = string,
    prefix = string,
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