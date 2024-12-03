
variable "myip" {
  description = "ip for ssh acess"
  type        = string
}

// VPC variables
variable "cidr_block" {
  description = "The CIDR block for the VPC"
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

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
}

variable "enviroment" {
  description = "tags"
  type        = string
}