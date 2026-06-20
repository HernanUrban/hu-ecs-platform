variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "ecr_repositories" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
