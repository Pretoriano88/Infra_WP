# Template de lançamento que especifica a configuração das instâncias EC2 WordPress
resource "aws_launch_template" "wordpress_lt" {
  # Prefixo para o nome do template de lançamento
  name_prefix = "wordpress-lt"

  # ID da AMI (Amazon Machine Image) que será usada para lançar as instâncias
  image_id = var.ami # Variável definida pelo usuário para escolher a imagem

  # Tipo da instância EC2 (por exemplo, t2.micro, t3.medium, etc.)
  instance_type = var.instance_type # Variável definida pelo usuário para escolher o tipo de instância

  # Chave SSH para acessar as instâncias
  key_name = var.key_name # Nome da chave SSH definida em outro recurso

  # Mapeamento de dispositivos de bloco (discos) para as instâncias
  block_device_mappings {
    device_name = "/dev/xvda" # Nome do dispositivo principal (EBS) da instância
    ebs {
      volume_size = 20 # Tamanho do volume EBS (20 GB)
    }
  }

  # Configuração das interfaces de rede das instâncias
  network_interfaces {
    # Associa um endereço IP público às instâncias (necessário para instâncias em subnets públicas)
    associate_public_ip_address = true

    # Grupos de segurança aplicados às interfaces de rede
    security_groups = [var.security_group_id]
  }

  # Script de inicialização (user_data) que configura o ambiente WordPress nas instâncias
  user_data = base64encode(
    templatefile("${path.module}/../scripts/ec2_wordpress.sh", { # Arquivo de script externo que será executado no lançamento da instância
      wp_db_name       = var.dbname,                             # Nome do banco de dados do WordPress
      wp_username      = var.user,                               # Nome do usuário do banco de dados
      wp_user_password = var.password,                           # Senha do usuário do banco de dados
      wp_db_host       = var.bd_adress                           # Endereço do banco de dados RDS
      efs_dns_name     = var.efs_dns_name
      //elasticache_adress = var.elasticache_address
    })
  )

}
