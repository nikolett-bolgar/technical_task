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
  type = list
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