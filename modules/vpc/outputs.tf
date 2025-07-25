output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}
output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public[*].id
}
output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = aws_subnet.private[*].id
}
output "default_security_group_id" {
  description = "The ID of the default security group."
  value       = aws_vpc.main.default_security_group_id
}