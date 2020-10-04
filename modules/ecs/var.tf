variable "ecs_name" {
  description = "The name of the ECS cluster"
}

variable "public_subnets" {
  description = "A number of subnets in CIDR notation for public use"
  default     = 2
}

variable "private_subnets" {
  description = "A number of subnets in CIDR notation for private use"
  default     = 2
}

variable "vpc_cidr" {
  description = "IP CIDR block of the vpc network"
}

variable "cluster_id" {
  description = "The ECS cluster ID"
}

variable "security_group" {
  description = "Security group name"
  default     = []
}