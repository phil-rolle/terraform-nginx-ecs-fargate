#modules/vpc/main.tf 
# This module sets up the VPC, subnets, and routing for the demo infrastructure.

#define the VPC and subnets
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "nginx-demo-vpc"
  }
}

# Set up DHCP options for the VPC
resource "aws_vpc_dhcp_options" "main" {
  domain_name = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    Name = "nginx-demo-dhcp-options"
  }
}

# Associate the DHCP options with the VPC
resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

# Create public subnets in the VPC using provided CIDR blocks from handout
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = "us-east-1a" # using provided subnet CIDR
  map_public_ip_on_launch = true
  tags = {
    Name = "nginx-demo-public-subnet-a"
  }

}
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = "us-east-1b" # using provided subnet CIDR
  map_public_ip_on_launch = true
  tags = {
    Name = "nginx-demo-public-subnet-b"
  }
}

# Create an Internet Gateway to allow public access to the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "nginx-demo-internet-gateway"
  }
}

# Create a route table for public subnets to route traffic through the Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "nginx-demo-public-route-table"
  }
}

# Create a route in the public route table to allow internet access *cannot pull image otherwise*
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate the public subnets with the public route table to enable internet access
resource "aws_route_table_association" "public_a" {
  route_table_id         = aws_route_table.public.id
  subnet_id = aws_subnet.public_a.id
}

# Associate the second public subnet with the public route table
resource "aws_route_table_association" "public_b" {
  route_table_id         = aws_route_table.public.id
  subnet_id = aws_subnet.public_b.id
}

