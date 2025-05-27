variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "nginx-demo"
}

variable "image_name" {
  description = "Docker image name for the ECS task"
  type        = string
  default     = "nginx:alpine"
}

variable "cpu" {
  description = "CPU units for task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory for task (MiB)"
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "ECS Task execution role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "ECS Task role ARN"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "private_subnets" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "listener_arn" {
  description = "ARN of the ALB listener"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "log_group_name" {
  type        = string
  description = "CloudWatch log group name"
  default     = "nginx-ecs-demo-logs"
}

variable "region" {
  description = "AWS Region"
  type        = string
}