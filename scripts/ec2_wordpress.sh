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