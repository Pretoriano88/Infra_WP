resource "aws_security_group" "ec2_docker" {
  name_prefix = "ec2_docker"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
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