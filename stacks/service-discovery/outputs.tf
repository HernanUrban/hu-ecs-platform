output "namespace_id" {
  value = module.cloudmap.namespace_id
}

output "namespace_arn" {
  value = module.cloudmap.namespace_arn
}

output "namespace_name" {
  value = module.cloudmap.namespace_name
}

output "service_arns" {
  value = {
    for k, v in module.services :
    k => v.service_arn
  }
}

output "service_ids" {
  value = {
    for k, v in module.services :
    k => v.service_id
  }
}
