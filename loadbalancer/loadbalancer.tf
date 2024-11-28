# Recurso que define o Application Load Balancer (ALB)
resource "aws_lb" "wordpress_alb" {
  # Nome do Load Balancer
  name = var.load_balancer_name

  # Indica se o Load Balancer é interno (somente acessível dentro da VPC) ou externo (acessível da Internet)
  internal = var.lb_internal_external

  # Tipo do Load Balancer, definido como "application" para Application Load Balancer
  load_balancer_type = var.load_balancer_type

  # Grupos de segurança associados ao Load Balancer. Esse SG deve permitir tráfego HTTP (porta 80)
  security_groups = [var.security_group_load_balancer_id]

  # Subnets em que o Load Balancer será criado, deve estar em subnets públicas para ser acessível
  subnets = [var.subnet_public_a_id, var.subnet_cidr_public_b_id]
}

# Listener do Load Balancer que escuta na porta 80 (HTTP)
resource "aws_lb_listener" "this" {
  # Referência ao ARN do Load Balancer criado anteriormente
  load_balancer_arn = aws_lb.wordpress_alb.arn

  # Porta na qual o listener vai escutar (HTTP usa a porta 80)
  port = var.listener_port

  # Protocolo usado para o listener (neste caso, HTTP)
  protocol = var.listener_protocol

  # Ação padrão quando uma requisição é recebida: encaminhar (forward) para o Target Group
  default_action {
    # Tipo de ação que será tomada: forward, ou seja, encaminhar o tráfego
    type = var.default_action_type

    # O ARN do Target Group para o qual o tráfego será encaminhado
    target_group_arn = aws_lb_target_group.this.arn
  }
}



/*Explicação Geral:
Load Balancer: Define um Application Load Balancer (ALB) que distribui o tráfego para suas instâncias EC2. Ele é configurado para ser acessível externamente (porta 80) e associado a subnets públicas.
Listener: É responsável por escutar na porta 80 (HTTP) e direcionar o tráfego para o grupo de destinos (Target Group).
Target Group: Agrupa as instâncias que irão receber o tráfego do Load Balancer. Também contém as configurações de health check, que garantem que as instâncias EC2 estão saudáveis.
Auto Scaling Attachment: Associa um Auto Scaling Group (ASG) ao Target Group para que o tráfego seja distribuído dinamicamente às instâncias gerenciadas pelo ASG, de acordo com a demanda.
Esses comentários ajudam a entender como o tráfego é roteado do ALB para as instâncias, garantindo balanceamento de carga e verificações de saúde para alta disponibilidade.

*/