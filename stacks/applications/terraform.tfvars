aws_region   = "us-east-1"
project_name = "hurban"
environment  = "dev"

applications = {
  "placeholder-api" = {
    ecr_repo_key      = "placeholder-api"
    image_tag         = "1.0.0"
    cpu               = 256
    memory            = 512
    container_port    = 8080
    desired_count     = 1
    health_check_path = "/placeholder/actuator/health"
    path_patterns     = ["/placeholder/*"]
    listener_priority = 100
    cloudmap_key      = "placeholder-api"
  },
  "hu-user-api" = {
    ecr_repo_key      = "hu-user-api"
    image_tag         = "1.0.0"
    cpu               = 256
    memory            = 512
    container_port    = 8080
    desired_count     = 2
    health_check_path = "/user/actuator/health"
    path_patterns     = ["/user/*"]
    listener_priority = 100
    cloudmap_key      = "hu-user-api"
  }
}
