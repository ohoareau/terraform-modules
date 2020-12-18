variable "subscriptions" {
  type = map(object({
    topic: string,
    url: string,
    filter: string,
  }))
}