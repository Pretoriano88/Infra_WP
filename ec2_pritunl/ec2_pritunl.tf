
// ssh-keygen com esse comando será criada uma chave publica 

resource "aws_instance" "ec2_pritunl" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.subnet_id
  security_groups = [var.vpc_security_group_id]
  user_data       = file("${path.module}/../scripts/ec2_pritunl.sh")

  tags = {
    Name = "Pritunl-${var.enviroment}"
  }
}