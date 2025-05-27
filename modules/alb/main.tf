# modules/alb/main.tf - Application Load Balancer (ALB) resources for the nginx demo
# This module creates an Application Load Balancer (ALB) with a target group and listener for the ECS Nginx service.

# Create an Application Load Balancer (ALB)
resource "aws_lb" "main" {
  name               = "nginx-alb" # Name for the ALB
  internal           = false # Set to false for internet-facing ALB
  load_balancer_type = "application" # Type of the load balancer
  security_groups    = [var.alb_sg_id] # Security group for the ALB
  subnets            = var.public_subnet_ids # Use public subnets for the ALB

  enable_deletion_protection = false # Disable deletion protection for the ALB (demo purposes)
  idle_timeout               = 60 # Idle timeout in seconds

  tags = {
    Name = "nginx-alb"
  }
}

# Create a target group for the ALB to route traffic to ECS tasks
resource "aws_lb_target_group" "main" {
  name     = "nginx-target-group" # Name for the target group
  port     = 80 # Port on which the target group listens
  protocol = "HTTP" # Protocol used for communication
  vpc_id   = var.vpc_id # VPC ID where the target group is created
  target_type = "ip" # Use IP target type for Fargate tasks

  health_check {
    path                = "/" # Health check path for the target group
    interval            = 30 # Interval between health checks in seconds
    timeout             = 5 # Timeout for health checks
    healthy_threshold   = 2 # Thresholds for successful health checks
    unhealthy_threshold = 2 # Thresholds for failures of health checks
    matcher             = "200-299" # HTTP status codes considered healthy
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# Create a listener for the ALB to forward traffic to the target group
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn # Reference the ALB created above
  port              = 80 # Port on which the listener listens
  protocol          = "HTTP" # Protocol used by the listener

  default_action {
    type             = "forward" # Action type for the listener - forward traffic
    target_group_arn = aws_lb_target_group.main.arn # Reference the target group created above
  } 
}