resource "aws_ecs_task_definition" "this" {

  family = "${local.name_prefix}-${var.service_name}"

  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = var.cpu
  memory = var.memory

  execution_role_arn = aws_iam_role.execution.arn
  task_role_arn      = aws_iam_role.task.arn

  runtime_platform {
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = var.image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        for k, v in var.environment_variables :
        {
          name  = k
          value = v
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
    }
  ])
}

resource "aws_ecs_service" "this" {

  name = var.service_name

  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.this.arn

  desired_count = var.desired_count

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  launch_type      = "FARGATE"
  platform_version = "LATEST"

  enable_execute_command = true

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  propagate_tags = "SERVICE"

  network_configuration {

    subnets = var.private_subnet_ids

    security_groups = [
      var.ecs_security_group_id
    ]

    assign_public_ip = false
  }

  service_registries {
    registry_arn = var.service_registry_arn
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.service_name
    container_port   = var.container_port
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
