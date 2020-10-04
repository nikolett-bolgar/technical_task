# Provider 
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# Modules
module "instances" {
  source = ".//modules/instances"

  aws_key_pair_name = var.aws_key_pair_name
  public_key_path   = var.public_key_path
  instance_type     = var.instance_type
  web_ami           = var.web_ami
  instance_count    = var.instance_count
  server_port       = var.server_port
  security_group    = module.vpc.security_group
  subnet_public     = module.vpc.subnet_public

}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  availability_zone    = var.availability_zone
  instances            = module.instances.instances

}

module "ecs" {
  source = ".//modules/ecs"

  ecs_name        = var.ecs_name
  cluster_id      = var.cluster_id
  public_subnets  = module.vpc.subnet_public
  private_subnets = module.vpc.subnet_private
  vpc_cidr        = module.vpc.vpc_cidr

}
