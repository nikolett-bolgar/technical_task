# Provider 
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

module "instances" {
  source = ".//modules/instances"

  aws_key_pair_name = var.aws_key_pair_name
  public_key_path   = var.public_key_path
  instance_type     = var.instance_type
  web_ami           = var.web_ami
  instance_count    = var.instance_count

}