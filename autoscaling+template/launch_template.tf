# Template de lançamento que especifica a configuração das instâncias EC2 WordPress
resource "aws_launch_template" "wordpress_lt" {
  # Prefixo para o nome do template de lançamento
  name_prefix = "wordpress-lt"

  # ID da AMI (Amazon Machine Image) que será usada para lançar as instâncias
  image_id = var.ami_image # Variável definida pelo usuário para escolher a imagem

  # Tipo da instância EC2 (por exemplo, t2.micro, t3.medium, etc.)
  instance_type = var.type_instance # Variável definida pelo usuário para escolher o tipo de instância

  # Chave SSH para acessar as instâncias
  key_name = aws_key_pair.keypair.key_name # Nome da chave SSH definida em outro recurso

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
    security_groups = [aws_security_group.sc-ec2-wordpress.id]
  }

  # Script de inicialização (user_data) que configura o ambiente WordPress nas instâncias
  user_data = base64encode(
    templatefile("ec2Wordpress.sh", {                                                       # Arquivo de script externo que será executado no lançamento da instância
      wp_db_name       = aws_db_instance.bdword.db_name,                                    # Nome do banco de dados do WordPress
      wp_username      = aws_db_instance.bdword.username,                                   # Nome do usuário do banco de dados
      wp_user_password = aws_db_instance.bdword.password,                                   # Senha do usuário do banco de dados
      wp_db_host       = aws_db_instance.bdword.address,                                    # Endereço do banco de dados RDS
      aws_elasticache  = "${aws_elasticache_cluster.cache_cluster.cache_nodes[0].address}", # Endereço do ElastiCache (usado para cache de página)
      efs_dns_name     = "${aws_efs_file_system.file_system_1.dns_name}"                    # Nome DNS do sistema de arquivos EFS compartilhado
    })
  )
}
