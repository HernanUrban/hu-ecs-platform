data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "hu-platform-tfstate"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}

module "ecs_cluster" {

  source = "../../modules/ecs-cluster"

  project_name = var.project_name
  environment  = var.environment

}

module "ecr" {

  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repositories = var.ecr_repositories

}

module "alb" {

  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id                = data.terraform_remote_state.networking.outputs.vpc_id
  public_subnet_ids     = data.terraform_remote_state.networking.outputs.public_subnet_ids
  alb_security_group_id = data.terraform_remote_state.networking.outputs.alb_security_group_id

}

