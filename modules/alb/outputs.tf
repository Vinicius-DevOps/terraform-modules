output "alb_arn" {
  description = "The ARN of the Application Load Balancer."
  value = aws_lb.main.arn
}
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value = aws_lb.main.dns_name
}
output "target_group_arn" {
  description = "The ARN of the Target Group."
  value = aws_lb_target_group.main.arn
}
output "listener_arn" {
  description = "The ARN of the Listener."
  value = aws_lb_listener.http.arn
}