# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

# Internet Gateway
resource "aws_internet_gateway" "main_vpc" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main"
  }
}

# Route table public subnet:
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
}

# Route table: attach Internet Gateway 
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_vpc.id
}

# Route table private subnet:
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
}

# Subnets : Private
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = var.availability_zone
  count             = length(var.private_subnets)

  tags = {
    Name = "Private Subnet"
  }
}

# Subnets : Public
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = var.availability_zone
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet-2"
  }
}

#Route Table Association 
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


