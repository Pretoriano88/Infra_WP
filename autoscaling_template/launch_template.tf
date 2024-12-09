# Template de lançamento que especifica a configuração das instâncias EC2 WordPress
resource "aws_launch_template" "wordpress_lt" {
  name_prefix = "wordpress-lt"
  image_id = var.ami 

  instance_type = var.instance_type 
  key_name = var.key_name 

  block_device_mappings {
    device_name = "/dev/xvda" 
    ebs {
      volume_size = 20 
    }
  }
 network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.security_group_id]
  }

  user_data = base64encode(
    templatefile("${path.module}/../scripts/ec2_wordpress.sh", { 
      wp_db_name       = var.dbname,                             
      wp_username      = var.user,                              
      wp_user_password = var.password,                           
      wp_db_host       = var.bd_adress                           
      efs_dns_name     = var.efs_dns_name
      elasticache_adress = var.elasticache_address
    })
  )

}
