# main.tf


# Chamadas para as definições de recursos em outros arquivos
module "vpc" {
  source = "./vpc"


  # VPC CIDR
  cidr_block = var.vpc_cidr

  # Subnet variables
  subnet_cidr_public_a = var.subnet_cidr_public_a
  subnet_cidr_public_b = var.subnet_cidr_public_b
  subnet_cidr_private_a = var.subnet_cidr_private_a
  subnet_cidr_private_b = var.subnet_cidr_private_b
  region = var.region
  //igw
  map_public_ip_on_launch = var.map_public_ip_on_launch

}

