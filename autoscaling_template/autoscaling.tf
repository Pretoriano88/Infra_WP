# Definição de um grupo de Auto Scaling para as instâncias EC2 que irão rodar o WordPress
resource "aws_autoscaling_group" "wordpress_asg" {
  # Quantidade desejada de instâncias em execução
  desired_capacity = 2

  # Número máximo de instâncias que o grupo de Auto Scaling pode escalar
  max_size = 4

  # Número mínimo de instâncias que devem sempre estar em execução
  min_size = 2

  # Identificadores das subnets onde as instâncias serão lançadas, deve ser em subnets públicas para permitir acesso externo
  vpc_zone_identifier = [var.subnet_public_a, var.subnet_public_b]
  # Template de lançamento que define a configuração de instâncias EC2
  launch_template {
    # ID do template de lançamento (referenciado abaixo)
    id = aws_launch_template.wordpress_lt.id

    # Utiliza a versão mais recente do template de lançamento
    version = "$Latest"
  }




}


/*
Explicação Geral:
Auto Scaling Group (aws_autoscaling_group):

Controle de capacidade: Define quantas instâncias EC2 são criadas e escaladas automaticamente, de acordo com a demanda (com tamanho mínimo, desejado e máximo).
Subnets: As instâncias são lançadas em subnets públicas para permitir o acesso da Internet.
Template de lançamento: O template de lançamento (aws_launch_template.wordpress_lt) define os detalhes da configuração de cada instância EC2.
Tags: Cada instância recebe tags específicas, como Name, Environment (produção) e Application (WordPress), para facilitar a identificação e gestão dos recursos.
Launch Template (aws_launch_template):

Imagem e tipo de instância: Especifica a AMI e o tipo de instância EC2 a ser usada.
Chave SSH: Define a chave que será usada para acessar a instância via SSH.
Disco: Mapeia o volume principal da instância (20 GB de EBS).
Rede: Configura a interface de rede, associando um IP público e grupos de segurança que controlam o acesso às instâncias.
User Data: Usa um arquivo de script (ec2Wordpress.sh) que automatiza a configuração do WordPress nas instâncias, conectando-as ao banco de dados RDS, ElastiCache e EFS (sistema de arquivos compartilhado).
*/