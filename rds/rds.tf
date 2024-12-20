resource "aws_db_instance" "bdword" {
  allocated_storage    = var.allo_stora
  db_name              = var.dbname
  engine               = var.engine
  engine_version       = var.v_engine
  instance_class       = var.classinstance
  username             = var.user
  password             = var.password
  port                 = var.port
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  multi_az             = var.multi_az
  // security e subnet groups que irá pertencer 
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  // Qual security group meu rdsficará 
  vpc_security_group_ids = [var.security_group_id]



  # Certificando que as alterações manuais de senha rds sejam ignoradas
  lifecycle {
    ignore_changes = [password]
  }

  tags = {
    Name = "RDS_MySQL-${var.enviroment}"
  }
}

