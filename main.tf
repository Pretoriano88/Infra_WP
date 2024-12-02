# main.tf


// Modules VPC 
module "vpc" {
  source = "./vpc"

  myip = var.myip
  # VPC CIDR
  cidr_block = var.vpc_cidr

  # Subnet variables
  subnet_cidr_public_a  = var.subnet_cidr_public_a
  subnet_cidr_public_b  = var.subnet_cidr_public_b
  subnet_cidr_private_a = var.subnet_cidr_private_a
  subnet_cidr_private_b = var.subnet_cidr_private_b
  region                = var.region
  //igw
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enviroment              = var.enviroment

}

/*
create key pair linux
ssh-keygen -t rsa -b 4096 -C "MyKeyPair"

windows(PowerShell)
ssh-keygen -t rsa -b 4096 -C "MyKeyPair"
*/

resource "aws_key_pair" "key_pair_pritunl" {
  key_name   = var.key_name
  public_key = file("C:/Users/Praetorian/Desktop/Infra aws - Copia/ch/my-key-pair.pub")
}


// Modules EC2
module "ec2_docker" {
  source = "./ec2_docker"

  ami                   = var.ami
  instance_type         = var.instance_type
  subnet_id             = module.vpc.subnet_private_b_id
  vpc_security_group_id = module.vpc.security_group_docker_id
  key_name              = var.key_name
  enviroment            = var.enviroment

}

module "ec2_pritunl" {
  source = "./ec2_pritunl"

  ami                   = var.ami
  instance_type         = var.instance_type
  subnet_id             = module.vpc.subnet_public_b_id
  vpc_security_group_id = module.vpc.security_group_pritunl_id
  key_name              = var.key_name
  enviroment            = var.enviroment


}

module "autoscaling_template" {
  source = "./autoscaling_template"

  ami               = var.ami
  key_name          = var.key_name
  instance_type     = var.instance_type
  subnet_public_a   = module.vpc.subnet_public_a_id
  subnet_public_b   = module.vpc.subnet_public_b_id
  security_group_id = module.vpc.security_group_ec2_wordpress_id
  dbname            = var.dbname
  user              = var.user
  password          = var.password
  bd_adress         = module.rds.bd_adress
  efs_dns_name      = module.efs.efs_dns_name
  //elasticache_address = module.elasticache.elasticache_adress

}

module "rds" {
  source = "./rds"

  allo_stora           = var.allo_stora
  dbname               = var.dbname
  engine               = var.engine
  v_engine             = var.v_engine
  classinstance        = var.classinstance
  user                 = var.user
  password             = var.password
  port                 = var.port
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  multi_az             = var.multi_az
  security_group_id    = module.vpc.security_group_rds_id
  subnet_public_a_id   = module.vpc.subnet_public_a_id
  subnet_public_b_id   = module.vpc.subnet_public_b_id
  enviroment           = var.enviroment
}

module "efs" {
  source = "./efs"

  subnet_public_id_a    = module.vpc.subnet_public_a_id
  subnet_public_id_b    = module.vpc.subnet_public_b_id
  security_group_efs_id = module.vpc.security_group_efs_id
}

/*
module "elasticache" {
  source = "./elasticache"

  subnet_private_a         = module.vpc.subnet_private_a_id
  subnet_private_b         = module.vpc.subnet_public_b_id
  security_group_memcached = module.vpc.security_group_memcached_id

}
*/

module "load_balancer" {
  source = "./loadbalancer"
   
  vpc_id = module.vpc.vpc_id
  subnet_public_a_id = module.vpc.subnet_public_a_id
  subnet_cidr_public_b_id = module.vpc.subnet_public_b_id
  security_group_load_balancer_id = module.vpc.security_group_load_balancer_id
  autoscaling_group_name = module.autoscaling_template.autoscaling_group_name
  load_balancer_name = var.load_balancer_name
  lb_internal_external = var.lb_internal_external
  load_balancer_type = var.load_balancer_type
  listener_port = var.listener_port
  listener_protocol = var.listener_protocol
  default_action_type = var.default_action_type
  target_group_name = var.target_group_name
  target_group_port = var.target_group_port
  target_group_protocol = var.target_group_protocol
  health_check_path = var.health_check_path
  health_check_port = var.health_check_port
  health_check_protocol = var.health_check_protocol
  healthy_threshold = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  health_check_matcher = var.health_check_matcher

}

module "cloudwatch_monitoring" {
  source = "./monitoring"

  region                       = module.vpc.vpc_id
  evaluation_periods           = var.evaluation_periods
  period                       = var.period
  statistic                    = var.statistic
  cpu_alarm_threshold          = var.cpu_alarm_threshold
  elasticache_memory_threshold = var.elasticache_memory_threshold
  autoscaling_group_name       = module.autoscaling_template.autoscaling_group_name
  rds_instance_identifier      = var.rds_instance_identifier
  //elasticache_cluster_id       = var.elasticache_cluster_id
  instance_id     = module.ec2_docker.instance_id
  
}
