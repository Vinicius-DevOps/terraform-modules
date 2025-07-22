output "security_group_id" {
  description = "The ID of the Security Group."
  value       = aws_security_group.main.id
}
output "security_group_name" {
  description = "The name of the Security Group."
  value       = aws_security_group.main.name
}