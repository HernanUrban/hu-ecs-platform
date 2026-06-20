output "service_names" {
  value = {
    for k, v in module.app : k => v.service_name
  }
}

output "target_group_arns" {
  value = {
    for k, v in module.app : k => v.target_group_arn
  }
}
