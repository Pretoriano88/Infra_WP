Solução de Infraestrutura para WordPress com Alta Disponibilidade e VPN na AWS

Descrição do Projeto

Este projeto apresenta uma solução completa para hospedar um site WordPress com alta disponibilidade na AWS, além de incluir uma infraestrutura segura para aplicações Docker em uma instância privada, acessível via VPN. A configuração prioriza escalabilidade, desempenho e segurança, utilizando serviços nativos da nuvem AWS.

Principais Componentes da Infraestrutura

Escalabilidade Automática (Auto Scaling): Garantia de alta disponibilidade e desempenho.

Sistema de Arquivos Compartilhado (EFS): Armazenamento de mídia compartilhado entre instâncias.

Banco de Dados Gerenciado (RDS Multi-AZ): Disponibilidade e consistência dos dados.

Cache de Banco de Dados (Elasticache): Melhoria no tempo de resposta das aplicações.

Balanceador de Carga (Load Balancer): Distribuição eficiente do tráfego.

Conexão Segura (VPN com Pritunl): Acesso à instância Docker em rede privada.

Monitoramento (CloudWatch): Alertas e métricas para manter a saúde da infraestrutura.

Ferramentas e Tecnologias

Terraform: Provisionamento automatizado.

AWS: Provedor de nuvem.

Docker: Gerenciamento de containers.

Pritunl: Configuração da VPN.

Ansible: Automatização de configurações.

Requisitos Necessários

Conta AWS ativa com permissões adequadas.

Terraform 1.1.7 ou superior.

AWS CLI configurado.

Ambiente Linux para execução dos comandos.

Como Configurar e Utilizar

Passo 1: Clonar o Repositório

Baixe os arquivos do projeto:

$ git clone https://github.com/Pretoriano88/Infra_WP.git
$ cd Infra_WP/terraform

Passo 2: Atualizar Variáveis

Edite o arquivo aws.tfvars com as informações da sua conta AWS, como região, credenciais e e-mail para os alertas do CloudWatch.

Passo 3: Inicializar o Terraform

Configure o ambiente para inicialização do Terraform:

$ terraform init

Passo 4: Gerar o Plano de Execução

Visualize as ações que serão realizadas antes de aplicar as alterações:

$ terraform plan -var-file="aws.tfvars"

Passo 5: Aplicar a Infraestrutura

Implemente os recursos na AWS:

$ terraform apply -var-file="aws.tfvars"

Confirme com yes quando solicitado.

Passo 6: Verificar o WordPress

Ao concluir o provisionamento, acesse o IP público das instâncias no navegador para validar o funcionamento do WordPress.

Configurando a VPN

Conecte-se à instância que hospeda o Pritunl:

ssh -i "chave_privada.pem" ubuntu@<ip_da_instancia>

Obtenha a chave de configuração:

sudo pritunl setup-key

Copie a chave gerada para usar na interface web do Pritunl.

Consulte as credenciais padrão de acesso:

sudo pritunl default-password

Configure o servidor:

Crie uma organização e adicione um usuário.

Configure a porta 14253 no servidor VPN.

Vincule a organização ao servidor e inicie-o.

Exporte o arquivo de configuração do usuário e importe-o no cliente Pritunl.

Observação Importante

Para evitar custos adicionais, recursos como o NAT Gateway e Elastic IP utilizados durante o provisionamento podem ser desativados após o funcionamento validado. Exemplo para excluir o NAT Gateway:

$ aws ec2 delete-nat-gateway --nat-gateway-id <id_nat_gateway>

