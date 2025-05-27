# modules/vpc/variables.tf 
# Input variables for the VPC module

# The ID of the VPC
variable "vpc_id" {
  description = "ID of the VPC. If not provided, a new VPC will be created."
  type        = string
}

# The CIDR block for the VPC to be created
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# List of CIDRs for public subnets - provided by the handout
variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}