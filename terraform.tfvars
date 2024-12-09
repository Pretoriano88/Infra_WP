
myip       = "179.251.169.95"
enviroment = "infra-aws"



// VPC Configuration
vpc_cidr = "10.0.0.0/16"
vpc_tags = "vpc"
region   = "us-east-1"

// Subnet Configuration
subnet_cidr_public_a    = "10.0.1.0/24"
subnet_cidr_public_b    = "10.0.2.0/24"
subnet_cidr_private_a   = "10.0.3.0/24"
subnet_cidr_private_b   = "10.0.4.0/24"
map_public_ip_on_launch = true

// Internet Gateway Configuration
igw_tags = "main-igw"


// EC2 Configuration
key_name      = "infra"
ami           = "ami-07d9b9ddc6cd8dd30"
instance_type = "t3.micro"



// RDS Variables

allo_stora           = 10                 // Allocated storage space (in GB)
dbname               = "bdwordpress"      // Name of the database
engine               = "mysql"            // Database engine 
v_engine             = "8.0"              // Database engine version
classinstance        = "db.t3.micro"      // RDS instance class
user                 = "elfos"            // Database username
password             = "elfos123"         // Database password
parameter_group_name = "default.mysql8.0" // RDS parameter group name
port                 = 3306               // Port used by the databases
skip_final_snapshot  = true               // Skip final snapshot upon RDS deletion
multi_az             = true               // Enable Multi-AZ deployment

// loadBalancer variables
load_balancer_name   = "wordpress-load-balancer"
lb_internal_external = false
load_balancer_type   = "application"
listener_port        = "80"
listener_protocol    = "HTTP"
default_action_type  = "forward"

// Variables for Target Group configuration
target_group_name     = "learn-asg-terramino"
target_group_port     = 80
target_group_protocol = "HTTP"
health_check_path     = "/"
health_check_port     = 80
health_check_protocol = "HTTP"
healthy_threshold     = 3
unhealthy_threshold   = 3
health_check_matcher  = "200-499"

// CLoudwatch

evaluation_periods           = 2
period                       = 120
statistic                    = "Average"
cpu_alarm_threshold          = 80
elasticache_memory_threshold = 10000000
autoscaling_group_name       = "example-autoscaling-group"
rds_instance_identifier      = "example-rds-instance"
elasticache_cluster_id       = "example-elasticache-cluster"
docker_instance_id           = "i-0abcd1234efgh5678"

// autoscaling_group
desired_capacity = 2
max_size = 3
min_size = 1
version_template = "$Latest"

//elasticach

cluster_id           = "cluster-example"
engine_elastic       = "memcached"
node_type            = "cache.m4.large"
num_cache_nodes      = 2
parameter_group_name_elastic = "default.memcached1.6"
port_elastic          = 11211
apply_immediately    = true


//SNS

protocolo = "email"
email = "joaopaulo_jp88@hotmail.com"