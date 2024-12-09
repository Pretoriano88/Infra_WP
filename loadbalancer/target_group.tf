# Definição do Target Group, que agrupa as instâncias que irão receber tráfego do Load Balancer
resource "aws_lb_target_group" "this" {
  name = var.target_group_name

  port = var.target_group_port

  protocol = var.target_group_protocol

  vpc_id = var.vpc_id

  health_check {
    path = var.health_check_path

    port = var.health_check_port

    protocol = var.health_check_protocol

    healthy_threshold = var.healthy_threshold

    unhealthy_threshold = var.healthy_threshold

    matcher = var.health_check_matcher
  }
}
resource "aws_autoscaling_attachment" "this" {

  autoscaling_group_name = var.autoscaling_group_name

  lb_target_group_arn = aws_lb_target_group.this.arn
}
