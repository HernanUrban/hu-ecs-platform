
output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
output "alb_security_group_id" { value = module.vpc.alb_security_group_id }
output "ecs_security_group_id" { value = module.vpc.ecs_security_group_id }
output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "alloy_security_group_id" {
  value = module.vpc.alloy_security_group_id
}
