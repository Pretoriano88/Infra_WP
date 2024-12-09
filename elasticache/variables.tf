variable "enviroment" {
  description = "tags enviroment"



}

variable "subnet_private_a" {

}

variable "subnet_private_b" {

}
variable "security_group_memcached" {

}

variable "cluster_id" {
  description = "ID of the ElastiCache cluster"
}

variable "engine_elastic" {
  description = "Type of the ElastiCache engine"
}

variable "node_type" {
  description = "Type of the ElastiCache node"
}

variable "num_cache_nodes" {
  description = "Number of cache nodes"
}

variable "parameter_group_name_elastic" {
  description = "Name of the ElastiCache parameter group"
}

variable "port_elastic" {
  description = "Port of the ElastiCache"
}

variable "apply_immediately" {
  description = "Apply changes immediately"
}