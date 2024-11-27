variable "ami" {
  description = "The AMI for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}


variable "subnet_id" {
  description = "ID da sub-rede privada para a instância EC2"
  type        = string
}

variable "vpc_security_group_id" {
  description = "value"
  type        = string

}

variable "key_name" {
  type = string

}
variable "enviroment" {
  
}