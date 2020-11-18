variable "name" {
  type = string
}

variable "email" {
  type = object({
    from     = string
    identity = string
  })
  default = null
}

variable "sms" {
  type = object({
    sender     = string
    short_code = string
  })
  default = null
}

variable "baidu" {
  type = object({
    api_key    = string
    secret_key = string
  })
  default = null
}

variable "apns" {
  type = object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  })
  default = null
}

variable "apns_sandbox" {
  type = object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  })
  default = null
}

variable "apns_voip" {
  type = object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  })
  default = null
}

variable "apns_voip_sandbox" {
  type = object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  })
  default = null
}

variable "assume_role_identifiers" {
  type    = list(string)
  default = []
}