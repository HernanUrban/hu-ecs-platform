data "terraform_remote_state" "networking" {

  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
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
