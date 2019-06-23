variable "zone" {
  type = "string"
}
variable "challenge_ttl" {
  default = 3600
}
variable "challenge_organization" {
  default = ""
}
variable "challenge_verification_id" {
  default = ""
}
