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