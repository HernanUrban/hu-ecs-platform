variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "otel_collector_endpoint" {
  type    = string
  default = "http://alloy.hu.internal:4318"
}

variable "applications" {
  type = map(object({
    ecr_repo_key                      = string
    image_tag                         = string
    cpu                               = number
    memory                            = number
    container_port                    = number
    desired_count                     = optional(number, 1)
    health_check_path                 = string
    path_patterns                     = list(string)
    listener_priority                 = number
    cloudmap_key                      = string
    environment_variables             = optional(map(string), {})
    health_check_interval             = optional(number, 30)
    health_check_timeout              = optional(number, 5)
    health_check_healthy_threshold    = optional(number, 3)
    health_check_unhealthy_threshold  = optional(number, 3)
    health_check_grace_period_seconds = optional(number, 0)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}