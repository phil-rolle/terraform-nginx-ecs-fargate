# modules/ecs/outputs.tf
# This module outputs key information about the ECS Nginx service on Fargate.

# Output the ID and name of the ECS cluster, the service name, and the task definition ARN.
output "cluster_id" {
  value = aws_ecs_cluster.main.id
  description = "ID of the ECS cluster"
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
  description = "Name of the ECS cluster"
}

output "service_name" {
  value = aws_ecs_service.nginx_service.name
  description = "Name of the ECS service" 
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.nginx_task.arn
}