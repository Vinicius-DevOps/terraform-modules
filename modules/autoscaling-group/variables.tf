variable "name" {
  description = "Base name for the Launch Template and Auto Scaling Group."
  type        = string
}
variable "ami_id" {
  description = "The ID of the AMI (Amazon Machine Image) to be used for the EC2 instances."
  type        = string
}
variable "instance_type" {
  description = "The EC2 instance type (e.g., t3.micro, t3.medium)."
  type        = string
}
variable "vpc_security_group_ids" {
  description = "A list of Security Group IDs to associate with the EC2 instances."
  type        = list(string)
}
variable "subnet_ids" {
  description = "A list of subnet IDs where the ASG instances will be launched."
  type        = list(string)
}
variable "target_group_arns" {
  description = "A list of ALB Target Group ARNs to attach to the ASG."
  type        = list(string)
  default     = []
}
variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling Group."
  type        = number
  default     = 1
}
variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling Group."
  type        = number
  default     = 3
}
variable "desired_capacity" {
  description = "The desired number of instances in the Auto Scaling Group at creation time."
  type        = number
  default     = 1
}
variable "user_data" {
  description = "Shell script to run at instance startup (user data)."
  type        = string
  default     = null
}
variable "key_name" {
  description = "The name of the EC2 key pair for SSH access."
  type        = string
  default     = null
}
variable "tags" {
  description = "A map of tags to apply to the ASG and Launch Template resources."
  type        = map(string)
  default     = {}
}
variable "environment" {
  description = "Environment name."
  type        = string
}
