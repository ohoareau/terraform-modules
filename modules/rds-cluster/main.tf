provider "aws" {
}

provider "aws" {
  alias = "acm"
}


locals {
  db_user           = var.db_master_username
  db_password       = var.db_master_password
  db_host           = aws_rds_cluster.db.endpoint
  db_port           = aws_rds_cluster.db.port
  db_name           = aws_rds_cluster.db.database_name
  db_url            = "mysql:host=${aws_rds_cluster.db.endpoint};dbname=${aws_rds_cluster.db.database_name};port=${aws_rds_cluster.db.port}"
  security_group_id = null == var.db_security_group_id ? aws_security_group.default[0].id : var.db_security_group_id
}

resource "aws_rds_cluster" "db" {
  cluster_identifier        = "${var.env}-${var.name}"
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  engine_mode               = var.db_engine_mode
  availability_zones        = var.db_availability_zones
  database_name             = var.db_name
  final_snapshot_identifier = "${replace(var.db_name, "_", "-")}-final"
  master_username           = var.db_master_username
  master_password           = var.db_master_password
  backup_retention_period   = var.db_backup_retention_period
  preferred_backup_window   = var.db_preferred_backup_window
  skip_final_snapshot       = false
  vpc_security_group_ids    = [aws_security_group.default.id]
  db_subnet_group_name      = aws_db_subnet_group.default.name
  enable_http_endpoint      = true

  apply_immediately         = true # dangerous !

  scaling_configuration {
    auto_pause               = var.db_auto_pause
    max_capacity             = var.db_max_capacity
    min_capacity             = var.db_min_capacity
    seconds_until_auto_pause = var.db_auto_pause_delay
  }
  lifecycle {
    ignore_changes = [engine_version]
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "default" {
  name        = "${var.env}_db_subnets"
  description = "Group of DB subnets - ${var.env}"
  subnet_ids  = [for k,v in var.db_subnets: v.id]
}

resource "aws_security_group" "default" {
  count       = null == var.db_security_group_id ? 1 : 0
  vpc_id      = var.db_vpc_id
  name        = format("%s-%s-sg", var.env, "aurora")
  description = format("Security Group for %s - %s", "aurora", var.env)
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "aurora-incoming" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = [for k,v in var.db_subnets: v.cidr_block]
  security_group_id = local.security_group_id
}
resource "aws_security_group_rule" "aurora-outgoing" {
  count             = null == var.db_security_group_id ? 1 : 0
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.security_group_id
}