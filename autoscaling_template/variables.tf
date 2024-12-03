//EC2
variable "ami" {
  description = "The AMI for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}
variable "subnet_public_a" {

}

variable "subnet_public_b" {

}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  type = string

}


//RDS 
variable "dbname" {
  description = "value"
  type        = string
}

variable "user" {
  description = "value"
  type        = string
}

variable "password" {
  description = "value"
  type        = string
}


variable "bd_adress" {
  type = string
}

variable "efs_dns_name" {

}

/*variable "elasticache_address" {

}*/

// autoscaling_group

variable "desired_capacity" {
  
}

variable "max_size" {
  
}

variable "min_size" {
  
}

variable "version_template" {
  
}