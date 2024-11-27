resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.this.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.this.id
}



# Associar a tabela de rotas NAt com a subnet privada
resource "aws_route_table_association" "private_route_association" {
  subnet_id      = aws_subnet.private_b.id # Esta é a subnet privada
  route_table_id = aws_route_table.private_route_table.id
}