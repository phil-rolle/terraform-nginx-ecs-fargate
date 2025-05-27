# variables.tf - Input variables for the demo infrastructure
# These variables control configuration for the AWS region, networking, ECS service, tagging, and logging.

# AWS region for the resources
variable "region" { 
  type        = string
  default     = "us-east-1"
}

# Networking variables for VPC, subnets, ECS cluster, and ECS task configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Availability zones for the VPC and ECS tasks
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# ECS configuration variables for cluster, task definition, and service
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "nginx-ecs-cluster"
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
