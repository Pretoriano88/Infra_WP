# Criar o NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_b.id 
  tags = {
    Name = "Nat_Gateway-${var.enviroment}"
  }
}