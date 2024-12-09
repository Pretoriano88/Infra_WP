variable "region" {
  description = "The AWS region to deploy resources."
}

variable "evaluation_periods" {
  description = "The number of periods over which data is evaluated to trigger an alarm."

}

variable "period" {
  description = "The period (in seconds) over which the specified statistic is applied."

}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric."

}

variable "cpu_alarm_threshold" {
  description = "The threshold for CPU utilization alarm."

}

variable "elasticache_memory_threshold" {
  description = "The threshold for freeable memory in ElastiCache alarms."

}

variable "autoscaling_group_name" {
  description = "The name of the Auto Scaling group."
}


variable "rds_instance_identifier" {
  description = "The identifier of the RDS instance."
}

variable "elasticache_cluster_id" {
  description = "The identifier of the ElastiCache cluster."
}

variable "instance_id_docker" {

}

