# modulr/alb/outputs.tf
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "listener_arn" {
  value = aws_lb_listener.http.arn
}