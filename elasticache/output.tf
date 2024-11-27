output "elasticache_adress" {
  value = aws_elasticache_cluster.example.cache_nodes[0].address
}