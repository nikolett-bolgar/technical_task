output "security_group" {
  description = "List of IDs of security groups"
  value       = aws_security_group.web-sg.id
}

output "subnet_public" {
  value       = aws_subnet.public.*.id
}