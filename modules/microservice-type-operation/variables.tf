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
variable "family" {
  type = string
}
variable "handler_name" {
  type = string
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
      variables: map(string),
      dynamodb-table-migration = object({
        arn: string,
      }),
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