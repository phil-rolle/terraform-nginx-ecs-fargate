# main.tf - Root module for this demo
# This root module orchestrates the core infrastructure components by
# leveraging separate reusable modules for IAM, VPC, Security Groups, ALB, and ECS.

terraform {
  required_version = ">= 1.12.1" # Ensure Terraform version is compatible
  
  required_providers {
    aws = {
      source  = "hashicorp/aws" # AWS provider for managing AWS resources
      version = "~> 5.0" # Use version 5.x of the AWS provider
    }
  }
}

# IAM module to create roles and policies needed for ECS tasks
module "iam" {
  source = "./modules/iam"
  name   = "nginx-demo-ecs-task-role"
  tags   = var.tags
}

# VPC module to create networking resources (VPC, subnets, routing)
module "vpc" { 
  source = "./modules/vpc"
  vpc_id = module.vpc.vpc_id
}

# Security module to create Security Groups linked to the VPC
module "security" {
    source = "./modules/security"
    vpc_id = module.vpc.vpc_id # Pass VPC ID to associate security groups with correct VPC
}

# Application Load Balancer module with associated security group and subnet information
module "alb" {
    source = "./modules/alb" 
    name = "nginx-demo-alb" # Name for the ALB
    vpc_id = module.vpc.vpc_id  #Pass the VPC ID to the ALB module 
    alb_sg_id = module.security.alb_sg_id # Security group for the ALB
    public_subnet_ids = module.vpc.public_subnet_ids # Use public subnets for the ALB
}

# ECS module to define the container cluster, task definitions, and service configuration
module "ecs" {
    source = "./modules/ecs"

  cluster_name       = var.ecs_cluster_name # Name for the ECS cluster
  cpu                = var.ecs_cpu # CPU units for the ECS task
  memory             = var.ecs_memory # Memory in MiB for the ECS task
  image_name         = var.ecs_image_name # Docker image for the ECS task
  task_role_arn      = module.iam.ecs_task_role_arn # IAM role for the ECS task
  execution_role_arn = module.iam.ecs_task_role_arn # IAM role for ECS task execution
  desired_count      = var.ecs_desired_count # Number of desired ECS tasks
  private_subnets    = module.vpc.public_subnet_ids   # Use public subnets for ECS tasks
  ecs_sg_id          = module.security.ecs_task_sg_id # Security group for ECS tasks
  target_group_arn   = module.alb.target_group_arn # Target group ARN for the ALB
  listener_arn       = module.alb.listener_arn # Listener ARN for the ALB
  log_group_name     = var.log_group_name # CloudWatch log group for ECS task logs
  region             = var.region # AWS region for the ECS resources
}
