variable "domain" {
  type = string
}
variable "zone" {
  type = string
}
variable "identities" {
  type = map(object({
    id                 = string
    verification_token = string
    region             = string
  }))
}
