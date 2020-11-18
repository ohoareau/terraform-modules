variable "name" {
  type = string
}

variable "email_channels" {
  type = map(object({
    from     = string
    identity = string
  }))
  default = {}
}

variable "sms_channels" {
  type = map(object({
    sender     = string
    short_code = string
  }))
  default = {}
}

variable "baidu_channels" {
  type = map(object({
    api_key    = string
    secret_key = string
  }))
  default = {}
}

variable "apns_channels" {
  type = map(object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  }))
  default = {}
}

variable "apns_sandbox_channels" {
  type = map(object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  }))
  default = {}
}

variable "apns_voip_channels" {
  type = map(object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  }))
  default = {}
}

variable "apns_voip_sandbox_channels" {
  type = map(object({
    certificate  = string
    private_key  = string
    bundle_id    = string
    team_id      = string
    token_key    = string
    token_key_id = string
  }))
  default = {}
}

variable "assume_role_identifiers" {
  type    = list(string)
  default = []
}