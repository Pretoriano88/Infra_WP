#Relaciona o Elasticache com a subnet privada a
resource "aws_elasticache_subnet_group" "this" {
  name       = "subnetElastic-Cache"
  subnet_ids = [aws_subnet.subnet-private-2a.id]
}