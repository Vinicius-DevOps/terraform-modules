# Security Group
resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

# Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  count             = length(var.ingress_rules)
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.ingress_rules[count.index].cidr_ipv4
  from_port         = var.ingress_rules[count.index].from_port
  ip_protocol       = var.ingress_rules[count.index].ip_protocol
  to_port           = var.ingress_rules[count.index].to_port
  description       = lookup(var.ingress_rules[count.index], "description", null)
}

# Egress Rules
resource "aws_vpc_security_group_egress_rule" "egress" {
  count             = length(var.egress_rules)
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.egress_rules[count.index].cidr_ipv4
  from_port         = var.egress_rules[count.index].from_port
  ip_protocol       = var.egress_rules[count.index].ip_protocol
  to_port           = var.egress_rules[count.index].to_port
  description       = lookup(var.egress_rules[count.index], "description", null)
}