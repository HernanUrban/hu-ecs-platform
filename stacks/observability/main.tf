data "terraform_remote_state" "networking" {
  backend = "local"
  config = {
    path = "../networking/terraform.tfstate"
  }
}

data "terraform_remote_state" "platform" {
  backend = "local"
  config = {
    path = "../platform/terraform.tfstate"
  }
}

data "terraform_remote_state" "service_discovery" {
  backend = "local"
  config = {
    path = "../service-discovery/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix  = "${var.project_name}-${var.environment}"
  ecr_registry = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  common_tags = merge({
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }, var.tags)
}

module "grafana_cloud_secret" {

  source      = "../../modules/secrets-manager"
  secret_name = "${local.name_prefix}-grafana-cloud"
  description = "Grafana Cloud OTLP credentials"
  secret_value = jsonencode({
    otlp_endpoint    = "https://placeholder.local/otlp"
    otlp_auth_header = "Basic PLACEHOLDER"
  })

  tags = local.common_tags
}

module "alloy" {

  source                  = "../../modules/alloy"
  aws_region              = var.aws_region
  project_name            = var.project_name
  environment             = var.environment
  cluster_name            = data.terraform_remote_state.platform.outputs.cluster_name
  private_subnet_ids      = data.terraform_remote_state.networking.outputs.private_subnet_ids
  alloy_security_group_id = data.terraform_remote_state.networking.outputs.alloy_security_group_id
  service_registry_arn    = data.terraform_remote_state.service_discovery.outputs.service_arns["alloy"]
  grafana_secret_arn      = module.grafana_cloud_secret.secret_arn
  image                   = "${local.ecr_registry}/${var.alloy_ecr_repository}:${var.alloy_image_tag}"
  cpu                     = var.alloy_cpu
  memory                  = var.alloy_memory
  desired_count           = var.alloy_desired_count
  tags                    = local.common_tags
}
