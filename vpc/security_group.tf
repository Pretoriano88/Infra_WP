resource "aws_security_group" "ec2-wordpress" {
  name        = "Allow ssh, http for wordpress"
  description = "Allow SSH, HTTP for wordpress source load balancer"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}/32"]
  }

  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "wordpress_template_SG-${var.enviroment}"
  }
}

resource "aws_security_group" "load_balancer" {
  name        = "Allow internet trafic"
  description = "Allow internet trafic for load balancer"
  vpc_id      = aws_vpc.this.id


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
    Name = "Load_balancer_SG-${var.enviroment}"
  }
}


resource "aws_security_group" "ec2_docker" {
  name   = "ec2_docker"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    description = "PVT_Instance"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2_docker_SG-${var.enviroment}"
  }
}

resource "aws_security_group" "pritunl_sg" {
  name        = "pritunl-sg"
  description = "Security group for Pritunl VPN Server"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}/32"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}/32"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Pritunl_SG-${var.enviroment}"
  }
}

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
    Name = "Rds_SG-${var.enviroment}"
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
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Efs_SG-${var.enviroment}"
  }
}

resource "aws_security_group" "memcached_sg" {
  name        = "memcached-security-group"
  description = "Security group for Memcached"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_a.cidr_block, aws_subnet.private_b.cidr_block]
  }

  // Regra de saída para permitir todo o tráfego
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Permite todo o tráfego
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Memcached_SG-${var.enviroment}"
  }
}


