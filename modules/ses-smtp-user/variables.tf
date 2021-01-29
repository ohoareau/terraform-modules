variable "name" {
  type        = string
  description = "Name of the IAM user"
}

variable "user_policy_name_prefix" {
  type        = string
  description = "Name prefix of the IAM policy that is assigned to the user"
  default     = "SESSendOnlyAccess"
}

variable "path" {
  type        = string
  description = "Path in which to create the user"
  default     = null
}

variable "permissions_boundary" {
  type        = string
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  default     = null
}