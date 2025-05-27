#modules/vpc/outputs.tf 
# Outputs for the VPC module

# Output vpc_id and public subnet IDs from the VPC module
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of IDs of the public subnets"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}