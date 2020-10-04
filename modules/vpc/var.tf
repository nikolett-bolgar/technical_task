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