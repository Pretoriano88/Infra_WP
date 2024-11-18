// Variáveis do RDS
allo_stora           = 10                 # Espaço de armazenamento alocado (em GB)
dbname               = "bdwordpress"      # Nome do banco de dados
engine               = "mysql"            # Engine do banco de dados
v_engine             = "8.0"              # Versão da engine do banco
classinstance        = "db.t3.micro"      # Classe da instância RDS
user                 = "elfos"            # Nome de usuário do banco de dados
password             = "elfos123"         # Senha do banco de dados
parameter_group_name = "default.mysql8.0" # Grupo de parâmetros do RDS
port                 = 3306               # Porta usada pelo banco de dados
skip_final_snapshot = true
multi_az = true