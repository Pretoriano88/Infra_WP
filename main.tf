# main.tf


// Modules VPC 
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


resource "aws_key_pair" "key_pair_pritunl" {
  key_name   = var.key_name
  public_key = file("C:/Users/Praetorian/Desktop/Infra aws/ch/my-key-pair.pub")
}


// Modules EC2
module "ec2_docker" {
  source = "./ec2_docker"

  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_private_b_id
  vpc_security_group_id = module.vpc.security_group_docker_id
  key_name = var.key_name
  
 
}

module "ec2_pritunl" {
  source = "./ec2_pritunl"

  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_public_b_id
  vpc_security_group_id = module.vpc.security_group_pritunl_id  
  key_name = var.key_name
  
  
 
}

