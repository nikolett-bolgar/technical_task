# AWS 
aws_access_key = "my-aws-access-key"
aws_secret_key = "my-aws-secret-key"
aws_region     = "eu-west-2"

#Modules/Instaces
aws_key_pair_name = "my-key-pair"
web_ami           = "ami-a1b2c3d4"
instance_type     = "t3.micro"
public_key_path   = "my-public-key"

#Modules/VPC
vpc_cidr          = "10.0.0.0/16"
public_subnets    = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets   = ["10.0.50.0/24", "10.0.51.0/24"]
availability_zone = "eu-west-2a"
server_port       = 8080
instances         = "web"
security_group    = "web-sg"
