# modules/iam/variables.tf
# Input variables for the IAM module

# Name of the IAM role to be created.
variable "name" {
  description = "Name of the IAM role"
  type        = string
}

# Tags to apply to the IAM resources.
variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}