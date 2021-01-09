variable "env" {
  type = string
}
variable "name" {
  type = string
}
variable "db_name" {
  type    = string
}
variable "db_engine" {
  type    = string
  default = "aurora-mysql"
}
variable "db_engine_version" {
  type    = string
  default = "5.7.mysql_aurora.2.03.2"
}
variable "db_engine_mode" {
  type    = string
  default = "serverless"
}
variable "db_preferred_backup_window" {
  type    = string
  default = "07:00-09:00"
}
variable "db_master_username" {
  type = string
}
variable "db_master_password" {
  type = string
}
variable "db_backup_retention_period" {
  type = number
}
variable "db_vpc_id" {
  type = string
}
variable "db_subnets" {
  type = map(object({
    id = string
    cidr_block = string
  }))
  default = {}
}
variable "db_availability_zones" {
  type    = list(string)
  default = []
}
variable "db_auto_pause" {
  type    = bool
  default = true
}
variable "db_auto_pause_delay" {
  type    = number
  default = 300
}
variable "db_max_capacity" {
  type    = number
  default = 4
}
variable "db_min_capacity" {
  type    = number
  default = 1
}
variable "db_security_group_id" {
  type    = string
  default = null
}