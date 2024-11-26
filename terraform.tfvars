
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
key_name      = "my-key-pair"
public_key    = "C:/Users/Praetorian/Desktop/Infra aws - Copia/ch/my-key-pair.pub"
ami           = "ami-07d9b9ddc6cd8dd30"
instance_type = "t3.micro"
enviroment    = "infra-aws"


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
multi_az             = false              // Enable Multi-AZ deployment
