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