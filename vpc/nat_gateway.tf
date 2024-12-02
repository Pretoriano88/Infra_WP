# Criar o NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_b.id /* Altere para o ID da sua subnet pública, é necessário usar a subnet pública.
   A subnet privada não deve ser usada aqui, pois o NAT Gateway precisa de um endereço IP público e, por isso,
    deve estar em uma subnet que tem acesso à internet.
*/
  tags = {
    Name = "Nat_Gateway-${var.enviroment}"
  }
}