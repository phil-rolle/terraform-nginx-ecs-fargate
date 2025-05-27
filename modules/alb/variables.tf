# modules/alb/variables.tf - Input variables for the ALB module
# This module defines the input variables required for configuring an Application Load Balancer (ALB) in AWS.

# Name prefix for resources
  description = "Name prefix for resources"
  type        = string
}

# ID of the VPC where the ALB will be created
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# List of public subnet IDs where the ALB will be deployed
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

# Security Group ID for the ALB
variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
}