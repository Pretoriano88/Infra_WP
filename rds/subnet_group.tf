resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "dbsubnet"
  subnet_ids = [var.subnet_private_a_id, var.subnet_private_b_id]

   tags = {
    Name = "Group_privatesubnet_rds-${var.enviroment}"
  }
}
