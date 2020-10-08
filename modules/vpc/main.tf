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
  availability_zone = element(var.availability_zone,count.index)
  count             = length(var.private_subnets)

  tags = {
    Name = "Private Subnet"
  }
}

# Subnets : Public
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zone,count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
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

#Security Group 
resource "aws_security_group" "web-sg" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id = aws_vpc.main_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.private_subnets
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a new load balancer
resource "aws_elb" "main-elb" {
  name               = "main-elb"
  subnets = aws_subnet.public.*.id
  security_groups = aws_security_group.web-sg.id


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = var.instances.id
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "terraform-elb"
  }
}
