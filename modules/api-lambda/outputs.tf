output "endpoint" {
  value = "https://${var.dns}"
}
output "internal_endpoint" {
  value = module.api.endpoint
}