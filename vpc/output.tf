
// Output for ec2 docker

output "subnet_public_a_id" {
  value = aws_subnet.public_a.id
  
}
output "subnet_public_b_id" {
  value = aws_subnet.public_b.id
}

output "subnet_cidr_private_a_id" {
  value = aws_subnet.private_a.id
}

output "subnet_private_b_id" {
  value = aws_subnet.private_b.id
}


output "security_group_docker_id" {
  value = aws_security_group.ec2_docker.id
}

// Output pritunl 



output "security_group_pritunl_id" {
  value = aws_security_group.pritunl_sg.id
}

output "security_group_rds_id" {
  value = aws_security_group.allow_rds.id
}

output "subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}

output "security_group_ec2_wordpress_id" {
  value = aws_security_group.ec2-wordpress.id
}