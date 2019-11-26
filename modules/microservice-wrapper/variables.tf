variable "microservice" {
  type = object({
    prefix = string,
    lambdas = map(object({
      lambda_arn = string,
    })),
    apis = map(object({
      assume_role = string
    })),
    sqs_queues = map(object({
      arn = string,
    })),
    sns_topics = map(object({
      arn = string,
    })),
  })
}
variable "operations" {
  type    = list(object({
    lambda_arn = string,
  }))
  default = []
}
variable "types" {
  type    = list(object({
  }))
  default = []
}