# modules/security/main.tf
resource "aws_security_group" "alb_sg" {
  name        = "nginx-demo-alb-sg"
  description = "Security group for the ALB"
  vpc_id      = var.vpc_id
  # Ensure the security group is created in the VPC specified by the variable

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from anywhere
    description = "Allow HTTP traffic"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }

    tags = {
        Name = "nginx-demo-alb-sg"
    }
}

resource "aws_security_group" "ecs_task_sg" {
  name        = "nginx-demo-ecs-task-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # Allow traffic from ALB security group
    description = "Allow HTTP traffic from ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "nginx-demo-ecs-task-sg"
  }
}