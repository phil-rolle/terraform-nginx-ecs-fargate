# modules/ecs/main.tf
# This module deploys an Nginx service on AWS ECS using Fargate.

# CloudWatch Log Group for ECS logs - added for troubleshooting and monitoring
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.log_group_name
  retention_in_days = 7
}

# ECS Cluster - this is where the ECS service will run
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

# ECS Fargate Service for Nginx
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.main.id # Reference the ECS cluster created above
  task_definition = aws_ecs_task_definition.nginx_task.arn # Reference the task definition created below
  desired_count   = var.desired_count # Number of desired tasks to run
  launch_type     = "FARGATE" # Use Fargate launch type for serverless container management

  network_configuration {
    subnets          = var.private_subnets # Use public subnets for the ECS tasks
    security_groups  = [var.ecs_sg_id] # Security group for the ECS tasks
    assign_public_ip = true # Assign public IPs to tasks for direct access
  }

  load_balancer {
    target_group_arn = var.target_group_arn # Target group ARN for the ALB
    container_name   = "nginx" # Name of the container in the task definition
    container_port   = 80 # Port on which the container listens
  }

  lifecycle {
    ignore_changes = [task_definition] # Ignore changes to task definition to prevent unnecessary updates
  }
}

# ECS Task Definition for Nginx
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task" # Name of the task definition family
  network_mode             = "awsvpc" # Use awsvpc network mode for Fargate tasks
  requires_compatibilities = ["FARGATE"] # Specify that this task definition is compatible with Fargate
  cpu                      = var.cpu # CPU units for the task
  memory                   = var.memory   # Memory in MiB for the task
  execution_role_arn       = var.execution_role_arn # IAM role for task execution
  task_role_arn            = var.task_role_arn # IAM role for the task itself

  container_definitions = jsonencode([
    {
      name      = "nginx" # Name of the container
      image     = var.image_name # Docker image for the container  
      essential = true # Mark this container as essential for the task
      portMappings = [ 
        {
          containerPort = 80 # Port on which the container listens
          hostPort      = 80 # Port on the host (Fargate) to map to the container
          protocol      = "tcp" # Protocol used for communication
        }
      ],
        logConfiguration = {
            logDriver = "awslogs" # Use AWS CloudWatch Logs for logging
            options = {
            "awslogs-group"         = var.log_group_name # CloudWatch Logs group for the container logs
            "awslogs-region"        = var.region # AWS region for the logs
            "awslogs-stream-prefix" = "${var.cluster_name}-nginx" # Prefix for log streams
            }
        }
    }
  ])
}
