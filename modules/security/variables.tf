# modules/security/variables.tf
# Input variables for the security module

# ID of the VPC where the security groups will be created.
variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}