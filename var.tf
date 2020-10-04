# AWS 
variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

# Modules/Instances
variable "aws_key_pair_name" {
  description = "AWS key name"
  default     = []
}

variable "public_key_path" {
  description = "Public key path"
  default     = []
}

variable "web_ami" {
  description = "ID of AMI to use for the instance"
  type        = string

}

variable "instance_type" {
  description = "The type of instance"
  type        = string

}

variable "instance_count" {
  default = "3"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}

#Modules/VPC
variable "vpc_cidr" {
  description = "IP CIDR block of the vpc network"
}

variable "enable_dns_hostnames" {
  description = "True if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "True if you want to use private DNS within the VPC"
  default     = true
}

variable "availability_zone" {
  description = "Availablity Zone"
  default     = []
}


variable "private_subnets" {
  description = "A number of subnets in CIDR notation for private use"
  default     = 2
}

variable "public_subnets" {
  description = "A number of subnets in CIDR notation for public use"
  default     = 2
}

variable "instances" {
  description = "Instance name"
  default     = []

}

# Modules/ECS
variable "ecs_name" {
  description = "The name of the ECS cluster"
}

variable "cluster_id" {
  description = "The ECS cluster ID"
}