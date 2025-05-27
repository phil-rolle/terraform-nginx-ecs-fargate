# modules/security/outputs.tf
# This module outputs the security group IDs for the ALB and ECS tasks.
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
  description = "ID of the ALB security group"
}

output "ecs_task_sg_id" {
  value = aws_security_group.ecs_task_sg.id
  description = "ID of the ECS task security group"
}
