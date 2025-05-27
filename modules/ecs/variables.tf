# modules/ecs/variables.tf
# Input variables for ECS module to deploy an Nginx service using AWS Fargate
# Note: This module assumes that the necessary IAM roles and policies for ECS and Fargate have been created in the iam module.

# Name of the ECS cluster and task definition, along with other configurations for deploying an Nginx service on AWS Fargate.
variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "nginx-demo"
}

# Name of the docker image to be used in the ECS task definition.
variable "image_name" {
  description = "Docker image name for the ECS task"
  type        = string
  default     = "nginx:alpine" # Default to a lightweight Nginx image
}

# Cpu units and memory for the ECS task definition (e.g., 256 = 0.25 vCPU)
variable "cpu" {
  description = "CPU units for task"
  type        = string
  default     = "256"
}

# Memory for the ECS task definition in MiB (e.g., 512 = 0.5 GiB)
variable "memory" {
  description = "Memory for task (MiB)"
  type        = string
  default     = "512"
}

# ARN of the IAM role for ECS task execution and permissions
variable "execution_role_arn" {
  description = "ECS Task execution role ARN"
  type        = string
}

# ARN of the IAM role for ECS tasks to assume
variable "task_role_arn" {
  description = "ECS Task role ARN"
  type        = string
}

# Number of desired ECS tasks to run
variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

# List of private subnets where ECS tasks will run
variable "private_subnets" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

# Security group ID for ECS tasks to control inbound/outbound traffic
variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

# ARN of the ALB listener to associate with the ECS service
variable "listener_arn" {
  description = "ARN of the ALB listener"
  type        = string
}

# ARN of the ALB target group to register ECS tasks with
variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

# CloudWatch log group name for ECS task logs
variable "log_group_name" {
  type        = string
  description = "CloudWatch log group name"
  default     = "nginx-ecs-demo-logs"
}

# AWS Region where the ECS resources will be deployed
variable "region" {
  description = "AWS Region"
  type        = string
}