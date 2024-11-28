variable "vpc_id" {
  description = "The VPC where the Target Group will be created (must match the VPC of the instances)"
  type        = string
}

variable "security_group_load_balancer_id" {
  
}
variable "subnet_public_a_id" {
  
}
variable "subnet_cidr_public_b_id" {
  
}

variable "autoscaling_group_name" {
  
}

variable "load_balancer_name" {
  description = "The name of the Load Balancer"
  type        = string
 
}

variable "lb_internal_external" {
  description = "Indicates if the Load Balancer is internal (accessible only within the VPC) or external (accessible from the Internet)"
  type        = bool
  
}

variable "load_balancer_type" {
  description = "Type of the Load Balancer, defined as 'application' for Application Load Balancer"
  type        = string

}

variable "listener_port" {
  description = "The port on which the listener will listen (HTTP uses port 80)"
  type        = string
 
}

variable "listener_protocol" {
  description = "Protocol used for the listener (in this case, HTTP)"
  type        = string

}

variable "default_action_type" {
  description = "Default action when a request is received: forward to the Target Group"
  type        = string

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
  
}

variable "health_check_port" {
  description = "Port used by the health check (same as the application, 80)"
  type        = number
  
}

variable "health_check_protocol" {
  description = "Protocol used for the health check"
  type        = string
 
}

variable "healthy_threshold" {
  description = "Number of consecutive checks required to consider the instance healthy"
  type        = number
}

variable "unhealthy_threshold" {
  description = "Number of consecutive checks before considering the instance unhealthy"
  type        = number
}

variable "health_check_matcher" {
  description = "HTTP codes considered valid for the health check (from 200 to 499)"
  type        = string

}