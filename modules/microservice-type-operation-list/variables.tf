variable "name" {
  type    = string
  default = ""
}
variable "enabled" {
  type    = bool
  default = true
}
variable "enabled_public" {
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
}
variable "api_enabled" {
  type    = bool
  default = true
}
variable "api_enabled_public" {
  type    = bool
  default = true
}
variable "type" {
  type = object({
    prefix = string,
    full_upper_name = string,
    full_upper_name_plural = string,
    dynamodb-table = object({
      arn: string,
    }),
    microservice = object({
      env = string,
      file = string,
      api = string,
      public_api = string,
      variables: map(string),
      dynamodb-table-migration = object({
        arn: string,
      }),
      api-resolvers: object({
        api_assume_role_arn: string,
      }),
      public-api-resolvers: object({
        api_assume_role_arn: string,
      }),
      sns-outgoing-topic: object({
        arn: string,
      }),
    })
  })
}
variable "resolver" {
  type = object({
    field = string,
    type = string,
    config = map(string),
  })
  default = {field = "", type = "Query", config = {}}
}
variable "public_resolver" {
  type = object({
    field = string,
    type = string,
    config = map(string),
  })
  default = {field = "", type = "Query", config = {}}
}