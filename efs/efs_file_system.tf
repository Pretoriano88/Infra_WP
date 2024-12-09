resource "aws_efs_file_system" "foo" {
  creation_token = "efs-system"

  tags = {
    Name = "efs system-${var.enviroment}"
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}



/*As políticas do ciclo de vida do EFS são:

Transição para IA – Instrui o gerenciamento do ciclo de vida sobre quando mover arquivos para o armazenamento de acesso infrequente,
que é otimizado em termos de custo para dados que são acessados ​​apenas algumas vezes a cada trimestre.
Por padrão, os arquivos que não são acessados ​​no armazenamento padrão por 30 dias são transferidos para IA.

Transição para o Archive – Instrui o gerenciamento do ciclo de vida sobre quando mover arquivos para a classe de armazenamento Archive,
 que é otimizada em termos de custo para dados que são acessados ​​apenas algumas vezes por ano ou menos. Por padrão, os arquivos que não
  são acessados ​​no armazenamento Standard por 90 dias são transferidos para o Archive.

Todas as operações de gravação em arquivos nas classes de armazenamento IA ou Archive do sistema de arquivos são primeiro gravadas nas classes de armazenamento Standard e,
 então, podem ser transferidas para a classe de armazenamento aplicável após 24 horas.


*/