aws_region   = "us-east-1"
project_name = "hurban"
environment  = "dev"

image_tag = "1.0.0"

cpu            = 256
memory         = 512
container_port = 8000

desired_count     = 1
health_check_path = "/placeholder/actuator/health"

path_patterns = [
  "/placeholder/*"
]

