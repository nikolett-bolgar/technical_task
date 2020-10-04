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
