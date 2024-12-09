resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold" //  O alarme é acionado se a métrica for maior que o limite definido.
  evaluation_periods  = var.evaluation_periods //2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.period  // 120
  statistic           = var.statistic //Average: A média das amostras no período de tempo
  threshold           = var.cpu_alarm_threshold // 80%

  alarm_description = "High CPU utilization alarm for EC2 instances"
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_out_policy.arn]
  ok_actions      = [aws_autoscaling_policy.scale_in_policy.arn]
}

//RDS CPU ----------------------------
resource "aws_sns_topic" "rds_cpu_rds" {
  name = "rds-cpu--alerts"
}

#Assinatura SNS
resource "aws_sns_topic_subscription" "email_subscription_cpu_docker" {
  topic_arn = aws_sns_topic.rds_cpu_rds.arn
  protocol  = var.protocolo
  endpoint  = var.email
}


resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_alarm" {
  alarm_name          = "HighRDSCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.period
  statistic           = var.statistic
  threshold           = var.cpu_alarm_threshold

  alarm_description = "High CPU utilization alarm for RDS instances"
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_identifier
  }


  alarm_actions   = [aws_sns_topic.rds_cpu_rds.arn]
  ok_actions = [aws_sns_topic.rds_cpu_rds.arn] 
}

// Memcached memory --------------------------------------
resource "aws_sns_topic" "memcached_memory" {
  name = "memcached-memory--alerts"
}

#Assinatura SNS
resource "aws_sns_topic_subscription" "email_subscription_memcached_memory" {
  topic_arn = aws_sns_topic.memcached_memory.arn
  protocol  = var.protocolo
  endpoint  = var.email
}

resource "aws_cloudwatch_metric_alarm" "memcached_memory_utilization_alarm" {
  alarm_name          = "HighMemcachedMemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods //2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = var.period //120
  statistic           = var.statistic //Average 
  threshold           = var.elasticache_memory_threshold // 10000000

  alarm_description = "Low available memory alarm for ElastiCache"
  dimensions = {
    CacheClusterId = var.elasticache_cluster_id
  }

  
  alarm_actions   = [aws_sns_topic.memcached_memory.arn]
  ok_actions = [aws_sns_topic.memcached_memory.arn] 
}

//Docker availabily

resource "aws_sns_topic" "docker_availability" {
  name = "docker_availability--alerts"
}

#Assinatura SNS
resource "aws_sns_topic_subscription" "email_subscription_docker_avaiability" {
  topic_arn = aws_sns_topic.docker_availability.arn
  protocol  = var.protocolo
  endpoint  = var.email
}
resource "aws_cloudwatch_metric_alarm" "docker_ec2_instance_alarm" {
  alarm_name          = "DockerInstanceAvailability"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/DOCKER"
  period              = var.period
  statistic           = "Maximum"
  threshold           = 1

  alarm_description = "Availability alarm for private EC2 instance running Docker"
  dimensions = {
    InstanceId = var.instance_id_docker
  }

  
   alarm_actions   = [aws_sns_topic.docker_availability.arn]
   ok_actions = [aws_sns_topic.docker_availability.arn] 
}


// Pritunl

resource "aws_sns_topic" "cpu_pritunl" {
  name = "pritunl-cpu--alerts"
}

#Assinatura SNS
resource "aws_sns_topic_subscription" "email_subscription_cpu_pritunl" {
  topic_arn = aws_sns_topic.cpu_pritunl.arn
  protocol  = var.protocolo
  endpoint  = var.email
}


resource "aws_cloudwatch_metric_alarm" "pritunl_cpu_utilization_alarm" {
  alarm_name          = "HighRDSCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/PRITUNL"
  period              = var.period
  statistic           = var.statistic
  threshold           = var.cpu_alarm_threshold

  alarm_description = "High CPU utilization alarm for RDS instances"
  dimensions = {
    DBInstanceIdentifier = var.aws_instance_ec2_pritunl_id
  }
  
  
   alarm_actions   = [aws_sns_topic.cpu_pritunl.arn]
   ok_actions = [aws_sns_topic.cpu_pritunl.arn] 
}