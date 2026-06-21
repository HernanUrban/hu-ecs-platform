variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "alloy_ecr_repository" {
  type = string
}

variable "alloy_image_tag" {
  type = string
}

variable "alloy_cpu" {
  type    = number
  default = 256
}

variable "alloy_memory" {
  type    = number
  default = 512
}

variable "alloy_desired_count" {
  type    = number
  default = 1
}

variable "tags" {
  type    = map(string)
  default = {}
}
