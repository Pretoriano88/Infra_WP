resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  vpc_zone_identifier = [var.subnet_public_a, var.subnet_public_b]
  launch_template {
    id = aws_launch_template.wordpress_lt.id

    version = var.desired_capacity
  }
}

