resource "aws_lb_target_group" "this" {

  name = substr(
    "${var.project_name}-${var.environment}-${var.service_name}-tg",
    0,
    32
  )

  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path     = var.health_check_path
    matcher  = "200"
    protocol = "HTTP"
  }

  tags = local.common_tags
}
resource "aws_lb_listener_rule" "this" {

  listener_arn = var.listener_arn
  priority     = var.listener_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = var.path_patterns
    }
  }
}
