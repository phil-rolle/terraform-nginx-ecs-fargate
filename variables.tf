# variables.tf - Input variables for the demo infrastructure
# These variables control configuration for the AWS region, networking, ECS service, tagging, and logging.

# AWS region for the resources
variable "region" { 
  type        = string
  default     = "us-east-1"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "nginx-demo-ecs-cluster"
}

variable "ecs_cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "256"
}

variable "ecs_memory" {
  description = "Memory (MiB) for ECS task"
  type        = string
  default     = "512"
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}

variable "ecs_image_name" {
  description = "Docker image name for ECS task"
  type        = string
  default     = "nginx:stable-alpine"
}

# Tags to apply to resources for organization and management
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Owner       = "demo-user"
    Project     = "nginx-ecs-demo"
  }
}

# CloudWatch Logs group name for ECS task logging
variable "log_group_name" {
  description = "CloudWatch Logs group name"
  type        = string
  default     = "nginx-ecs-demo-logs"
}
