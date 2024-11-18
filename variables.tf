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



//ec2 variables
variable "key_name" {
  description = "name key"
  type        = string
  default     = "my-key-pair"

}

variable "public_key" {
  description = "path file"
  type        = string
  default     = "C:/Users/Praetorian/Desktop/Infra aws/ch/my-key-pair.pub"

}

variable "ami" {
  description = "The AMI for the EC2 instance"
  type        = string
  default     = "ami-07d9b9ddc6cd8dd30"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"
}


variable "enviroment" {
  description = "tags enviroment"
  type        = string
  default     = "infra-aws"

}

// RDS variables 

variable "allo_stora" {
  type        = number
  description = "Espaço alocado para armazenamento no RDS (em GB)"
}

variable "dbname" {
  type        = string
  description = "Nome do banco de dados que será criado no RDS"
}

variable "engine" {
  type        = string
  description = "Engine do banco de dados RDS (ex: mysql, postgres, etc.)"
}

variable "v_engine" {
  type        = string
  description = "Versão da engine do banco de dados"
}

variable "classinstance" {
  type        = string
  description = "Classe da instância RDS (ex: db.t3.micro)"
}

variable "user" {
  type        = string
  description = "Nome de usuário para acessar o banco de dados"
}

variable "password" {
  type        = string
  description = "Senha para acessar o banco de dados"
}

variable "parameter_group_name" {
  type        = string
  description = "Nome do grupo de parâmetros do RDS"
}

variable "port" {
  type        = number
  description = "Porta usada pelo banco de dados RDS"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "skip snapshot in finish rds"
}
variable "multi_az" {
  description = "RDS Multi Avaiable zone"
  type        = bool
}