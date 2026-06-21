variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "tfstate_bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name for Terraform state"
}
