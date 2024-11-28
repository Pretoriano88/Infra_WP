resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "dbsubnet"
  subnet_ids = [var.subnet_public_a_id, var.subnet_public_b_id]

  tags = {
    Name = "Grupo do RDS subnets privadas"
  }
}
