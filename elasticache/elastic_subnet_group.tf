resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [var.subnet_private_a, var.subnet_private_b]

  tags = {
    Name = "My Subnet Group-${var.enviroment}"
  }
}