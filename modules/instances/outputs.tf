
output "instances" {
  description = "List of IDs of instances"
  value       = aws_instance.web.*.id
}