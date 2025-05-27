# modules/alb/outputs.tf - Outputs for the ALB module
# This module outputs the DNS name of the Application Load Balancer (ALB), target group ARN, and listener ARN.

# Output the DNS name
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

# Output the target group ARN
output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

# Output the listener ARN
output "listener_arn" {
  value = aws_lb_listener.http.arn
}