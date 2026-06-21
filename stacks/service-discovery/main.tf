data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "hu-platform-tfstate"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}

module "cloudmap" {

  source         = "../../modules/cloudmap"
  namespace_name = var.namespace_name
  vpc_id         = data.terraform_remote_state.networking.outputs.vpc_id

  tags = var.tags

}


module "services" {

  source       = "../../modules/cloudmap-service"
  for_each     = toset(var.services)
  namespace_id = module.cloudmap.namespace_id
  service_name = each.value

  tags = var.tags

}
