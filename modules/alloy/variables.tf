variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alloy_security_group_id" {
  type = string
}

variable "service_registry_arn" {
  type = string
}

variable "grafana_secret_arn" {
  type = string
}

variable "image" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
