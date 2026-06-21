data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "hu-platform-tfstate"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "platform" {
  backend = "s3"
  config = {
    bucket = "hu-platform-tfstate"
    key    = "platform/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "service_discovery" {
  backend = "s3"
  config = {
    bucket = "hu-platform-tfstate"
    key    = "service-discovery/terraform.tfstate"
    region = "us-east-1"
  }
}

module "app" {

  source   = "../../modules/ecs-service"
  for_each = var.applications

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  service_name = each.key

  image = "${data.terraform_remote_state.platform.outputs.repository_urls[each.value.ecr_repo_key]}:${each.value.image_tag}"

  cpu    = each.value.cpu
  memory = each.value.memory

  container_port        = each.value.container_port
  desired_count         = each.value.desired_count
  health_check_path     = each.value.health_check_path
  path_patterns         = each.value.path_patterns
  cluster_name          = data.terraform_remote_state.platform.outputs.cluster_name
  private_subnet_ids    = data.terraform_remote_state.networking.outputs.private_subnet_ids
  ecs_security_group_id = data.terraform_remote_state.networking.outputs.ecs_security_group_id
  vpc_id                = data.terraform_remote_state.networking.outputs.vpc_id
  listener_arn          = data.terraform_remote_state.platform.outputs.listener_arn
  listener_priority     = each.value.listener_priority
  service_registry_arn  = data.terraform_remote_state.service_discovery.outputs.service_arns[each.value.cloudmap_key]

  health_check_interval             = each.value.health_check_interval
  health_check_timeout              = each.value.health_check_timeout
  health_check_healthy_threshold    = each.value.health_check_healthy_threshold
  health_check_unhealthy_threshold  = each.value.health_check_unhealthy_threshold
  health_check_grace_period_seconds = each.value.health_check_grace_period_seconds

  environment_variables = merge(
    {
      OTEL_SERVICE_NAME           = each.key
      OTEL_EXPORTER_OTLP_ENDPOINT = var.otel_collector_endpoint
      OTEL_EXPORTER_OTLP_PROTOCOL = "http/json"
      OTEL_TRACES_EXPORTER        = "otlp"
      OTEL_METRICS_EXPORTER       = "otlp"
      OTEL_LOGS_EXPORTER          = "otlp"
    },
    each.value.environment_variables
  )

  tags = var.tags
}
