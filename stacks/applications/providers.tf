terraform {

  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "hu-platform-tfstate"
    key          = "applications/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
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
