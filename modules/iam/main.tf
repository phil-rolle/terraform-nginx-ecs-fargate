#modules/iam/main.tf
# This module sets up the IAM role for ECS tasks with the necessary permissions.

# Define assume role policy for ECS tasks
data "aws_iam_policy_document" "ecs_task_execution_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"] # Action to assume the role

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"] # ECS tasks service principal
    }
  }
}

# IAM role for ECS tasks
resource "aws_iam_role" "ecs_task_role" {
  name               = var.name # Name of the IAM role, passed as a variable
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role_policy.json # Use the assume role policy defined above
  tags               = var.tags 
}

# Attach the AmazonECSTaskExecutionRolePolicy to the ECS task role
# Grant permissions for ECS tasks to pull images and write logs
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_role.name 
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" # Managed policy for ECS task execution
}