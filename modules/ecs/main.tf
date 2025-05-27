# This module deploys an Nginx service on AWS ECS using Fargate.
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}
# This module deploys an Nginx service on AWS ECS using Fargate.
resource "aws_ecs_service" "nginx_service" {
  name            = "${var.cluster_name}-nginx-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.cluster_name}-nginx"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition] # Avoid replacement on minor image changes
  }
}

resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "${var.cluster_name}-nginx-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.cluster_name}-nginx"
      image     = var.image_name  
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ],
        logConfiguration = {
            logDriver = "awslogs"
            options = {
            "awslogs-group"         = var.log_group_name
            "awslogs-region"        = var.region
            "awslogs-stream-prefix" = "${var.cluster_name}-nginx"
            }
        }
    }
  ])
}
