# Definição do Target Group, que agrupa as instâncias que irão receber tráfego do Load Balancer
resource "aws_lb_target_group" "this" {
  # Nome do Target Group
  name = var.target_group_name

  # Porta na qual o Target Group vai receber tráfego (HTTP na porta 80)
  port = var.target_group_port

  # Protocolo usado para comunicação (HTTP)
  protocol = var.target_group_protocol

  # VPC onde o Target Group será criado (deve corresponder à VPC das instâncias)
  vpc_id = var.vpc_id

  # Configurações de health check para garantir que as instâncias estão funcionando
  health_check {
    # Caminho a ser verificado para o health check (raiz do servidor, "/")
    path = var.health_check_path

    # Porta usada pelo health check (mesma da aplicação, 80)
    port = var.health_check_port

    # Protocolo usado para o health check
    protocol = var.health_check_protocol

    # Número de verificações consecutivas necessárias para considerar a instância saudável
    healthy_threshold = var.healthy_threshold

    # Número de verificações consecutivas antes de considerar a instância não saudável
    unhealthy_threshold = var.healthy_threshold

    # Códigos HTTP considerados válidos para o health check (de 200 a 499)
    matcher = var.health_check_matcher
  }
}

# Associa o Auto Scaling Group (ASG) ao Target Group do Load Balancer
resource "aws_autoscaling_attachment" "this" {
  # Nome do Auto Scaling Group que será associado ao Target Group
  autoscaling_group_name = var.autoscaling_group_name

  # ARN do Target Group para onde o tráfego será direcionado
  lb_target_group_arn = aws_lb_target_group.this.arn
}
