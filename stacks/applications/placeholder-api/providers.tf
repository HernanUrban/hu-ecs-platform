terraform {

  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Owner"       = "hurban"
      "Environment" = var.environment
      "Project"     = var.project_name
      "ManagedBy"   = "terraform"
    }
  }
}
