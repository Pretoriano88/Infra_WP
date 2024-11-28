resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [var.security_group_memcached]
  subnet_group_name    = aws_elasticache_subnet_group.memcached_subnet_group.name
  apply_immediately    = true

  tags = {
    Name = "WordPress Memcached"
  }
}