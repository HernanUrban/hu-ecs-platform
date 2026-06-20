output "grafana_secret_arn" {
  value = module.grafana_cloud_secret.secret_arn
}

output "grafana_secret_name" {
  value = module.grafana_cloud_secret.secret_name
}

output "alloy_service_name" {
  value = module.alloy.service_name
}

output "alloy_task_definition_arn" {
  value = module.alloy.task_definition_arn
}

output "alloy_log_group_name" {
  value = module.alloy.log_group_name
}
