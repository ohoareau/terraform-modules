resource "aws_ecs_cluster" "cluster" {
  count = var.enabled ? 1 : 0
  name  = "${var.env}-${var.name}"
  tags  = {
    Env = var.env
  }
}