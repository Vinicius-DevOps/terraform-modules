variable "name" {
  description = "Name of the Security Group."
  type        = string
  default     = "security-group"
}
variable "description" {
  description = "Description of the Security Group."
  type        = string
  default     = "Security Group created by Terraform."
}
variable "vpc_id" {
  description = "VPC ID where the Security Group will be created."
  type        = string
}
variable "tags" {
  description = "Tags to be applied to the Security Group."
  type        = map(string)
  default     = {}
}
variable "ingress_rules" {
  description = "List of ingress rules for the Security Group."
  type = list(object({
    from_port   = number
    to_port     = number
    cidr_ipv4   = string
    ip_protocol = string
    description = optional(string, null)
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
    description = "Allow all inbound traffic"
  }]
}
variable "egress_rules" {
  description = "List of egress rules for the Security Group."
  type = list(object({
    from_port   = number
    to_port     = number
    cidr_ipv4   = string
    ip_protocol = string
    description = optional(string, null)
  }))
  default = [ # Default: allow all outbound traffic
    {
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}