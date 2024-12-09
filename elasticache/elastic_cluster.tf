resource "aws_elasticache_cluster" "example" {
  cluster_id           = var.cluster_id
  engine               = var.engine_elastic
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name_elastic
  port                 = var.port_elastic
  security_group_ids   = [var.security_group_memcached]
  subnet_group_name    = aws_elasticache_subnet_group.memcached_subnet_group.name
  apply_immediately    = var.apply_immediately

  tags = {
    Name = "WordPress Memcached-${var.enviroment}"
  }
}


