variable "policies" {
  type = map(object({
    id      = string,
    arn     = string,
    sources = list(string)
  }))
}