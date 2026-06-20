variable "namespace_id" {
  type = string
}

variable "service_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
