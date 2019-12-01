locals {
  variables            = merge(
    var.variables,
    var.microservice.variables,
    {
    }
  )
  definition_variables = merge(
    var.definition_vars,
    {
      NAME       = "${var.microservice.prefix}-${var.name}"
      IMAGE      = var.image
      LOGS_GROUP = var.enabled ? aws_cloudwatch_log_group.loggroup[0].name : null
      ENV_VARS   = local.variables
    }
  )
}

resource "aws_ecs_service" "service" {
  count            = var.enabled ? 1 : 0
  name             = "${var.microservice.prefix}-${var.name}"
  cluster          = var.cluster
  task_definition  = var.enabled ? aws_ecs_task_definition.task[0].arn : null
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  network_configuration {
    subnets = var.subnets
  }
  tags = merge(
    var.tags,
    {
      Env          = var.microservice.env
      Microservice = var.microservice.name
    }
  )
}

resource "aws_ecs_task_definition" "task" {
  count                    = var.enabled ? 1 : 0
  family                   = "${var.microservice.prefix}-${var.name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = templatefile(var.definition_file, local.definition_variables)
  execution_role_arn       = var.enabled ? aws_iam_role.ecs_task_execution[0].arn : null
  task_role_arn            = var.enabled ? aws_iam_role.ecs_task[0].arn : null
}

resource "aws_cloudwatch_log_group" "loggroup" {
  count             = var.enabled ? 1 : 0
  name              = "fargate/${var.microservice.prefix}-${var.name}"
  retention_in_days = 14
}

data "aws_iam_policy_document" "ecs_task_execution_assume_role" {
  count = var.enabled ? 1 : 0
  statement {
    sid    = "AllowECSTasksToAssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
data "aws_iam_policy_document" "ecs_task_execution_role" {
  count = var.enabled ? 1 : 0
  statement {
    sid    = "AllowECSToWriteLogsToCloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = var.enabled ? [aws_cloudwatch_log_group.loggroup[0].arn] : []
  }
  statement {
    sid = "AllowECSToAccessEcr"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
    ]
    resources = ["*"]
  }
}
data "aws_iam_policy_document" "ecs_task_assume_role" {
  count = var.enabled ? 1 : 0
  statement {
    sid    = "AllowECSTasksToAssumeRole"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  count              = var.enabled ? 1 : 0
  name               = "ecs-task-execution-${var.microservice.prefix}-${var.name}-execution"
  assume_role_policy = var.enabled ? data.aws_iam_policy_document.ecs_task_execution_assume_role[0].json : null
}
resource "aws_iam_role" "ecs_task" {
  count              = var.enabled ? 1 : 0
  name               = "ecs-task-execution-${var.microservice.prefix}-${var.name}"
  assume_role_policy = var.enabled ? data.aws_iam_policy_document.ecs_task_assume_role[0].json : null
}

resource "aws_iam_role_policy" "ecs_task_execution" {
  count  = var.enabled ? 1 : 0
  name   = "ecs-task-execution-${var.microservice.prefix}-${var.name}-policy"
  role   = var.enabled ? aws_iam_role.ecs_task_execution[0].name : null
  policy = var.enabled ? data.aws_iam_policy_document.ecs_task_execution_role[0].json : null
}