# modules/iam/outputs.tf
# Output the ARN of the ECS task execution role created in this module.
# This value is often needed by other modules (e.g., ECS task definition).

output "ecs_task_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_role.arn
}