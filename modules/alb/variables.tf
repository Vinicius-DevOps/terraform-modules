variable "name" {
  description = "Name of the Application Load Balancer."
  type        = string
  default     = "alb"
}
variable "internal" {
  description = "Indicates whether the Application Load Balancer is internal or not."
  type        = bool
  default     = false
}
variable "security_groups_ids" {
  description = "List of Security Group IDs for the Application Load Balancer."
  type        = list(string)
  default     = []
}
variable "subnets_ids" {
  description = "List of Subnet IDs for the Application Load Balancer."
  type        = list(string)
}
variable "target_group_name" {
  description = "Target Group name. If not provided, the default will be the ALB name followed by '-tg'."
  type        = string
  default     = null
}
variable "target_group_port" {
  description = "Target Group port used to route traffic."
  type        = number
  default     = 80
}
variable "target_group_protocol" {
  description = "The protocol used by the Target Group (HTTP, HTTPS, TCP, TLS, UDP, TCP_UDP, GENEVE)."
  type        = string
  default     = "HTTP"
}
variable "health_check_path" {
  description = "Health Check path."
  type        = string
  default     = "/"
}
variable "health_check_port" {
  description = "Health Check port."
  type        = string
  default     = "traffic-port"
}
variable "vpc_id" {
  description = "VPC ID."
  type        = string
}
variable "listener_port" {
  description = "The port on which the ALB will listen."
  type        = number
  default     = 80
}
variable "listener_protocol" {
  description = "The protocol used by the Listener (HTTP, HTTPS, TCP, TLS, UDP, TCP_UDP, GENEVE)."
  type        = string
  default     = "HTTP"
}
variable "tags" {
  description = "Tags to be applied to the Application Load Balancer."
  type        = map(string)
  default     = {}
}