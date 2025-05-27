#modules/vpc/main.tf

#define the VPC and subnets
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "nginx-demo-vpc"
  }
}

resource "aws_vpc_dhcp_options" "main" {
  domain_name = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    Name = "nginx-demo-dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

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

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "nginx-demo-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "nginx-demo-public-route-table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_a" {
  route_table_id         = aws_route_table.public.id
  subnet_id = aws_subnet.public_a.id
}

resource "aws_route_table_association" "public_b" {
  route_table_id         = aws_route_table.public.id
  subnet_id = aws_subnet.public_b.id
}

