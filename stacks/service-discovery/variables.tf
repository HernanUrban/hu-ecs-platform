variable "aws_region" {
  type = string
}

variable "namespace_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}
variable "services" {
  type = list(string)
}
variable "tags" {
  type    = map(string)
  default = {}
}
