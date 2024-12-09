# Recurso que define o Application Load Balancer (ALB)
resource "aws_lb" "wordpress_alb" {
  name = var.load_balancer_name

  internal = var.lb_internal_external

  load_balancer_type = var.load_balancer_type

  security_groups = [var.security_group_load_balancer_id]

  subnets = [var.subnet_public_a_id, var.subnet_cidr_public_b_id]
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.wordpress_alb.arn

  port = var.listener_port

  protocol = var.listener_protocol

  default_action {
    type = var.default_action_type

    target_group_arn = aws_lb_target_group.this.arn
  }
}



