#!/bin/bash

# Atualiza os pacotes
sudo apt update && sudo apt upgrade -y
sudo apt-get install nfs-common -y
sudo su -

# Subindo WordPress com Ansible  
cd /tmp
wget https://github.com/Pretoriano88/ansible-wordpress/archive/refs/heads/main.zip
sudo apt install unzip -y
unzip main.zip
cd ansible-wordpress-main
sudo apt install curl ansible -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update

# Executar o playbook Ansible para configurar o WordPress
sudo ansible-playbook wordpress.yml --extra-vars "wp_db_name=${wp_db_name} wp_db_username=${wp_username} wp_db_password=${wp_user_password} wp_db_host=${wp_db_host} session_save_path=''"

# Ponto de montagem EFS compartilhado
sudo mkdir -p /var/www/html/wp-content/uploads
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ /var/www/html/wp-content/uploads
echo "${efs_dns_name}:/ /var/www/html/wp-content/uploads nfs4 defaults,_netdev 0 0" | sudo tee -a /etc/fstab


# Instalar WordPress CLI para facilitar a configuração
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html

# Configurar o Memcached para usar o cluster

sudo apt-get install -y php7.4-memcached memcached
echo "session.save_handler = memcached" >> /etc/php/7.4/fpm/php.ini
echo "session.save_path = '${elasticache_adress }'" >> /etc/php/7.4/fpm/php.ini
sudo systemctl restart php7.4-fpm

# Configurar o WordPress para usar Memcached
wp config set WP_CACHE true --path="/var/www/html/wordpress" --allow-root
wp config set memcached_servers "array( 'default' => array( '${elasticache_adress }' ) );" --path="/var/www/html/wordpress" --allow-root
sudo systemctl restart php7.4-fpm  

