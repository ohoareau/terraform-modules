resource "aws_ecr_repository" "repository" {
  name = "${var.env}-${var.name}"
}