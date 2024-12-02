resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
    tags = {
    Name = "Public_Route_Table-${var.enviroment}"
  }

}


# Criar uma tabela de rotas para a subnet privada
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id # Altere para o ID do seu VPC

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id # Rota padrão para o NAT Gateway
  }
    tags = {
    Name = "Private_Route_Table-${var.enviroment}"
  }
}