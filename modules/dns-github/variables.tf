variable "zone" {
  type = string
}
variable "challenge_ttl" {
  type    = number
  default = 3600
}
variable "challenge_organization" {
  type    = string
  default = ""
}
variable "challenge_verification_id" {
  type    = string
  default = ""
}
