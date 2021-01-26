variable "name" {
  type = string
}
variable "lambda_arn" {
  type    = string
}
variable "lambda_role_name" {
  type    = string
}
variable "visibility_timeout_seconds" {
  type    = number
  default = null
}
variable "message_retention_seconds" {
  type    = number
  default = null
}
variable "max_message_size" {
  type    = number
  default = null
}
variable "delay_seconds" {
  type    = number
  default = null
}
variable "receive_wait_time_seconds" {
  type    = number
  default = null
}
variable "fifo_queue" {
  type    = bool
  default = null
}
