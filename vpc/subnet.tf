resource "aws_subnet" "public_a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_public_a
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = var.map_public_ip_on_launch
}
resource "aws_subnet" "public_b" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_public_b
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = var.map_public_ip_on_launch

}
resource "aws_subnet" "private_a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_private_a
 availability_zone = "${var.region}a"

}
resource "aws_subnet" "private_b" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_private_b
  availability_zone = "${var.region}b"

}

