output "security_group" {
  description = "List of IDs of security groups"
  value       = aws_security_group.web-sg.id
}

output "subnet_public" {
  value       = aws_subnet.public.*.id
}

output "subnet_private" {
    value = aws_subnet.private.*.id
}

output "vpc_cidr" {
  value       = var.vpc_cidr
}