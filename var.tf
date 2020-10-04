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
