variable "subscriptions" {
  type = map(object({
    topic: string,
    queue: string,
    filter: string,
  }))
}