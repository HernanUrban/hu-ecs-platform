data "terraform_remote_state" "networking" {

  backend = "local"

  config = {
    path = "../../networking/terraform.tfstate"
  }
}

data "terraform_remote_state" "platform" {

  backend = "local"

  config = {
    path = "../../platform/terraform.tfstate"
  }
}

data "terraform_remote_state" "service_discovery" {

  backend = "local"

  config = {
    path = "../../service-discovery/terraform.tfstate"
  }
}

module "placeholder_api" {

  source = "../../../modules/ecs-service"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  service_name = "placeholder-api"

  image = "${data.terraform_remote_state.platform.outputs.repository_urls["cbl-placeholder-api"]}:${var.image_tag}"

  cpu    = var.cpu
  memory = var.memory

  container_port        = var.container_port
  desired_count         = var.desired_count
  health_check_path     = var.health_check_path
  path_patterns         = var.path_patterns
  cluster_name          = data.terraform_remote_state.platform.outputs.cluster_name
  private_subnet_ids    = data.terraform_remote_state.networking.outputs.private_subnet_ids
  ecs_security_group_id = data.terraform_remote_state.networking.outputs.ecs_security_group_id
  vpc_id                = data.terraform_remote_state.networking.outputs.vpc_id
  listener_arn          = data.terraform_remote_state.platform.outputs.listener_arn
  listener_priority     = 100
  service_registry_arn  = data.terraform_remote_state.service_discovery.outputs.service_arns["cbl-placeholder-api"]

  environment_variables = {
    OTEL_SERVICE_NAME           = "placeholder-api"
    OTEL_EXPORTER_OTLP_ENDPOINT = "http://alloy.hu.internal:4318"
    OTEL_EXPORTER_OTLP_PROTOCOL = "http/json"
    OTEL_TRACES_EXPORTER        = "otlp"
    OTEL_METRICS_EXPORTER       = "otlp"
    OTEL_LOGS_EXPORTER          = "otlp"
  }

  tags = var.tags
}
