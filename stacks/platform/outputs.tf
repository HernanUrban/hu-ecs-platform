output "cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "cluster_arn" {
  value = module.ecs_cluster.cluster_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "repository_urls" {
  value = module.ecr.repository_urls
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "listener_arn" {
  value = module.alb.listener_arn
}
