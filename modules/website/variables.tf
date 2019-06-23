variable "name" {
  type = "string"
}
variable "bucket_name" {
  type = "string"
}
variable "zone" {
  type = "string"
}
variable "dns" {
  type = "string"
}
variable "error_403_path" {
  default = "/403.html"
}
variable "error_404_path" {
  default = "/404.html"
}
