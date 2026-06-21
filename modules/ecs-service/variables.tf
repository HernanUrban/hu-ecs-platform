variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "service_name" {
  type = string
}

variable "image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "service_registry_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "listener_arn" {
  type = string
}

variable "listener_priority" {
  type = number
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "path_patterns" {
  type = list(string)
}

variable "health_check_interval" {
  type    = number
  default = 30
}

variable "health_check_timeout" {
  type    = number
  default = 5
}

variable "health_check_healthy_threshold" {
  type    = number
  default = 3
}

variable "health_check_unhealthy_threshold" {
  type    = number
  default = 3
}

variable "health_check_grace_period_seconds" {
  type    = number
  default = 0
}

variable "tags" {
  type    = map(string)
  default = {}
}
