output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group."
  value       = aws_autoscaling_group.main.name
}
output "launch_template_id" {
  description = "The ID of the Launch Template."
  value       = aws_launch_template.main.id
}
output "launch_template_arn" {
  description = "The ARN of the Launch Template."
  value       = aws_launch_template.main.arn
}