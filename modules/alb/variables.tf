# modules/alb/variables.tf - Input variables for the ALB module
# This module defines the input variables required for configuring an Application Load Balancer (ALB) in AWS.

# Name prefix for resources, VPC ID, public subnet IDs, and security group ID for the ALB.
variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
}