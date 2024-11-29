// VPC variables
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string

}
variable "vpc_tags" {
  description = "The tags for the VPC"
  type        = string

}
// region   
variable "region" {
  description = "The region for the VPC"
  type        = string

}

// Subnet variables
variable "subnet_cidr_public_a" {
  description = "The CIDR block for the subnet"
  type        = string

}
variable "subnet_cidr_public_b" {
  description = "The CIDR block for the subnet"
  type        = string

}
variable "subnet_cidr_private_a" {
  description = "The CIDR block for the subnet"
  type        = string

}
variable "subnet_cidr_private_b" {
  description = "The CIDR block for the subnet"
  type        = string

}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool

}

// Internet Gateway variables
variable "igw_tags" {
  description = "The tags for the Internet Gateway"
  type        = string

}



//ec2 variables
variable "key_name" {
  description = "name key"
  type        = string


}

variable "public_key" {
  description = "path file"
  type        = string


}

variable "ami" {
  description = "The AMI for the EC2 instance"
  type        = string

}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string

}


variable "enviroment" {
  description = "tags enviroment"
  type        = string


}

// RDS variables 

variable "allo_stora" {
  type        = number
  description = "Space for RDS (GB)"
}

variable "dbname" {
  type        = string
  description = "RDS Name"
}

variable "engine" {
  type        = string
  description = "RDS Engine (ex: mysql, postgres, etc.)"
}

variable "v_engine" {
  type        = string
  description = "Version engine"
}

variable "classinstance" {
  type        = string
  description = "Class instance (ex: db.t3.micro)"
}

variable "user" {
  type        = string
  description = "RDS user name"
}

variable "password" {
  type        = string
  description = "RDS Password"
}

variable "parameter_group_name" {
  type        = string
  description = "parameter group"
}

variable "port" {
  type        = number
  description = "RDS port"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "skip snapshot in finish rds"
}
variable "multi_az" {
  description = "RDS Multi Avaiable zone"
  type        = bool
}

// loadBalancer variables

variable "load_balancer_name" {
  description = "The name of the Load Balancer"
  type        = string
  default     = "wordpress-load-balancer"
}

variable "lb_internal_external" {
  description = "Indicates if the Load Balancer is internal (accessible only within the VPC) or external (accessible from the Internet)"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of the Load Balancer, defined as 'application' for Application Load Balancer"
  type        = string
  default     = "application"
}

variable "listener_port" {
  description = "The port on which the listener will listen (HTTP uses port 80)"
  type        = string
  default     = "80"
}

variable "listener_protocol" {
  description = "Protocol used for the listener (in this case, HTTP)"
  type        = string
  default     = "HTTP"
}

variable "default_action_type" {
  description = "Default action when a request is received: forward to the Target Group"
  type        = string
  default     = "forward"
}

# Variables for Target Group configuration

variable "target_group_name" {
  description = "The name of the Target Group"
  type        = string
  default     = "learn-asg-terramino"
}

variable "target_group_port" {
  description = "The port on which the Target Group will receive traffic (HTTP on port 80)"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol used for communication (HTTP)"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Path to be checked for health check (root of the server, '/')"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port used by the health check (same as the application, 80)"
  type        = number
  default     = 80
}

variable "health_check_protocol" {
  description = "Protocol used for the health check"
  type        = string
  default     = "HTTP"
}

variable "healthy_threshold" {
  description = "Number of consecutive checks required to consider the instance healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Number of consecutive checks before considering the instance unhealthy"
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  description = "HTTP codes considered valid for the health check (from 200 to 499)"
  type        = string
  default     = "200-499"
}

//cloudwatch



variable "evaluation_periods" {
  description = "The number of periods over which data is evaluated to trigger an alarm."
  default     = 2
}

variable "period" {
  description = "The period (in seconds) over which the specified statistic is applied."
  default     = 300
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric."
  default     = "Average"
}

variable "cpu_alarm_threshold" {
  description = "The threshold for CPU utilization alarm."
  default     = 80
}

variable "elasticache_memory_threshold" {
  description = "The threshold for freeable memory in ElastiCache alarms."
  default     = 10000000
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

variable "docker_instance_id" {
  description = "The ID of the EC2 instance running Docker."
}
