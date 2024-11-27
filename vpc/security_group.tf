resource "aws_security_group" "ec2-wordpress" {
  name        = "pemitir ssh, http for wordpress"
  description = "Allow SSH, HTTP for wordpress"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Wordpress-sg"
  }
}

resource "aws_security_group" "ec2_docker" {
  name_prefix = "ec2_docker"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "pritunl_sg" {
  name        = "pritunl-sg"
  description = "Security group for Pritunl VPN Server"
  vpc_id      = aws_vpc.this.id

  # Porta de gerenciamento do Pritunl (default: 443 para gerenciamento via web)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Porta de VPN Pritunl
  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH para administração
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # Regras de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Pritunl sg"
  }
}

# Security group RDS
resource "aws_security_group" "allow_rds" {
  name        = "allow_rds"
  description = "Allow MySQL traffic from EC2 instances"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.public_a.cidr_block,
      aws_subnet.public_b.cidr_block
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Rds-sg"
  }
}

resource "aws_security_group" "efs_sg" {
  name        = "efs-security-group"
  description = "Security group for EFS"
  vpc_id      = aws_vpc.this.id


  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = [
      aws_subnet.public_a.cidr_block,
    aws_subnet.public_b.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" // Permitir todo o tráfego de saída
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Efs-sg"
  }
}

resource "aws_security_group" "memcached_sg" {
  name        = "memcached-security-group"
  description = "Security group for Memcached"
  vpc_id      = aws_vpc.this.id // Substitua pelo ID da sua VPC

  // Regra de entrada para permitir tráfego na porta 11211
  ingress {
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Altere para o CIDR apropriado para sua segurança
  }

  // Regra de saída para permitir todo o tráfego
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Permite todo o tráfego
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Memcached Security Group"
  }
}