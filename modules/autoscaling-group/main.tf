# Lounch Template
resource "aws_launch_template" "main" {
  name_prefix   = "lt-${var.environment}"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = var.user_data != null ? base64decode(var.user_data) : null

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 30
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      {
        Name = "${var.name}-instance"
      },
      var.tags
    )
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(
      {
        Name = "${var.name}-volume"
      },
      var.tags
    )
  }

  tags = merge(
    {
      Name = "${var.name}-launch-template"
    },
    var.tags
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "main" {
  name                = "asg-${var.environment}"
  vpc_zone_identifier = var.subnet_ids
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  target_group_arns   = var.target_group_arns # Attaches to the ALB Target Group

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest" # Always use the latest version of the Launch Template
  }

  health_check_type    = "ELB" # Uses Load Balancer's health check
  termination_policies = ["Default"]

  tag {
    key                 = "Name"
    value               = "${var.name}-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = lookup(var.tags, "Environment", "default")
    propagate_at_launch = true
  }
}
