resource "aws_ecs_service" "this" {

  name                               = "alloy"
  cluster                            = var.cluster_name
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = var.desired_count
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  enable_execute_command             = true
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  propagate_tags                     = "SERVICE"

  network_configuration {
    subnets = var.private_subnet_ids
    security_groups = [
      var.alloy_security_group_id
    ]
    assign_public_ip = false
  }

  service_registries {
    registry_arn = var.service_registry_arn
  }

  depends_on = [
    aws_ecs_task_definition.this
  ]

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }

  tags = local.common_tags
}

resource "aws_ecs_task_definition" "this" {

  family                   = "${local.name_prefix}-observability-alloy"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.task.arn
  runtime_platform {
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name      = "alloy"
      image     = var.image
      essential = true
      portMappings = [
        {
          containerPort = 4317
          protocol      = "tcp"
        },
        {
          containerPort = 4318
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }

      secrets = [
        {
          name      = "OTLP_ENDPOINT"
          valueFrom = "${var.grafana_secret_arn}:otlp_endpoint::"
        },
        {
          name      = "OTLP_AUTH_HEADER"
          valueFrom = "${var.grafana_secret_arn}:otlp_auth_header::"
        }
      ]
    }
  ])
}
