// VPC variables
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "vpc_tags" {
  description = "The tags for the VPC"
  type        = string
  default     = "vpc"
}
// region   
variable "region" {
  description = "The region for the VPC"
  type        = string
  default     = "us-east-1"
}

// Subnet variables
variable "subnet_cidr_public_a" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "subnet_cidr_public_b" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.2.0/24"
}
variable "subnet_cidr_private_a" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.3.0/24"
}
variable "subnet_cidr_private_b" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
  default     = true
}

// Internet Gateway variables
variable "igw_tags" {
  description = "The tags for the Internet Gateway"
  type        = string
  default     = "main-igw"
}   



