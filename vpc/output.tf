
// Output for ec2 docker
output "vpc_id" {
   value = aws_vpc.this.id
}

output "subnet_public_a_id" {
  value = aws_subnet.public_a.id

}
output "subnet_public_b_id" {
  value = aws_subnet.public_b.id
}

output "subnet_private_a_id" {
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

output "security_group_ec2_wordpress_id" {
  value = aws_security_group.ec2-wordpress.id
}


output "security_group_efs_id" {
  value = aws_security_group.efs_sg.id
}

output "security_group_memcached_id" {
  value = aws_security_group.memcached_sg.id
}
output "security_group_load_balancer_id" {
  value = aws_security_group.load_balancer.id
}