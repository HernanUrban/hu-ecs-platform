resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.name_prefix}/${var.service_name}"
  retention_in_days = 30
  tags              = local.common_tags
}
