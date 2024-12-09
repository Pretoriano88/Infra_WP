resource "aws_efs_mount_target" "mount_target" {
  count          = length(var.subnet_ids)  // Adiciona um mount target para cada subnet
  file_system_id = aws_efs_file_system.foo.id
  subnet_id      = var.subnet_ids[count.index]  // Usa o índice do count para acessar a subnet
  security_groups = [var.security_group_efs_id]
}


/*Um mount target no Amazon EFS (Elastic File System) é um ponto de acesso que permite que suas instâncias EC2 conectem-se a um sistema de arquivos EFS dentro de uma VPC. Ele funciona como um gateway que associa o sistema de arquivos a uma subnet específica em sua rede.

Conceitos Chave
1. Papel do Mount Target
Permite que instâncias EC2 acessem o sistema de arquivos via NFSv4.1 ou NFSv4.2.
Funciona como o ponto de entrada para o tráfego da rede da VPC ao EFS.
2. Requisitos de Subnet
Um mount target deve ser configurado em uma subnet por zona de disponibilidade (AZ).
Para acessar o EFS de uma instância EC2, a instância deve estar na mesma AZ do mount target ou em uma rede conectada (ex.: via peering ou VPN).
3. Associação com Security Groups
Você pode associar security groups ao mount target para definir regras de segurança (como permitir conexões via porta NFS: 2049).
4. Alta Disponibilidade
Para garantir alta disponibilidade, recomenda-se criar um mount target em cada AZ onde suas instâncias EC2 estão sendo executadas.

*/