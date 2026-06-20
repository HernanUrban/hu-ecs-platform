locals {

  common_tags = merge({
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }, var.tags)

}

resource "aws_ecr_repository" "this" {

  for_each = toset(var.repositories)

  name = each.value

  lifecycle {
    prevent_destroy = false
  }

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = each.value
    }
  )

}
