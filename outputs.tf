
# outputs.tf - Outputs from root module for demo infrastructure
# These outputs expose key resource identifiers and ARNs
# that can be used by other Terraform configurations or automation scripts.

# Output the VPC ID, public subnet IDs, ALB DNS name, ECS cluster name, and other key identifiers
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

# Output the IDs of public subnets created in the VPC
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

# Output the DNS name of the Application Load Balancer (ALB)
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

# Output the ARN of the target group associated with the ALB
output "alb_target_group_arn" {
  description = "ARN of the target group attached to the ALB"
  value       = module.alb.target_group_arn
}

# Output the name of the ECS cluster created
output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

# Output the name of the ECS service created
output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

# Output the ARN of the ECS task definition
output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}

# Output the IAM role ARN for the ECS task
output "alb_sg_id" {
  description = "Security group ID for ALB"
  value       = module.security.alb_sg_id
}

# Output the IAM role ARN for the ECS task
output "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  value       = module.security.ecs_task_sg_id
}