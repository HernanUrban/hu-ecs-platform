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

variable "tags" {
  type    = map(string)
  default = {}
}
