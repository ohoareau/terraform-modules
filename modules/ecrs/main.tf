resource "aws_ecr_repository" "repository" {
  for_each = var.enabled ? var.repositories : {}
  name     = "${var.env}-${each.key}"
}