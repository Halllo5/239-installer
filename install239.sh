#!/bin/bash

#Name of Script
#https://patorjk.com/software/taag/#p=display&v=2&c=echo&f=ANSI%20Regular&t=239%20Installer
echo "██████  ██████   █████      ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████  ";
echo "     ██      ██ ██   ██     ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██ ";
echo " █████   █████   ██████     ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████  ";
echo "██           ██      ██     ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██ ";
echo "███████ ██████   █████      ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██ ";
echo "                                                                                                  ";
echo "                                                                                                  ";


#Check if APT is installed
if ! command -v apt &> /dev/null
then
    echo "APT Could not be found"
    echo "Be sure to install APT or use a Linux Disto wich has it installed by default"
    echo "This script was only testet on Ubuntu Server 22.04 LTS (Raspberry Pi 4B 8GB)"
    echo "Bye bye"

    exit
fi

#Chck if MySQL and WordPress CLI is installed
if ! command -v apache2 &> /dev/null
then
    echo "Apache coud not be found let me try to install it"
    sudo apt update
    sudo apt install apache2
fi
if ! command -v mysql &> /dev/null
then
    echo "MySQL coud not be found let me try to install it"
    sudo apt update
    sudo apt install mysql-server
fi
if ! command -v php &> /dev/null
then
    echo "PHP coud not be found let me try to install it"
    sudo apt update
    sudo apt install php libapache2-mod-php php-mysql
fi
if ! command -v wp &> /dev/null
then
    echo "WP CLI coud not be found let me try to install it"
    sudo apt update
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    php wp-cli.phar --info
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
fi
#Deactivate MySQL PW Policy
sudo mysql < sql/nopolicy.sql

echo "!!! Do you want to install phpMyAdmin (Recomended) otherwies you will have to create a MySQL Account with all rights by yourself !!!"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed && chmod 777 ftp/install.sh && sudo ./ftp/install.sh && sudo apt-get install mcrypt && sudo service apache2 restart && sudo apt-get install phpmyadmin && chmod 777 wordpress/install.sh && chmod 777 wordpress/uninstall.sh && chmod 777 wordpress/reinstall.sh && ./wordpress/install.sh;;
	no ) echo Installing with advanced mode... && chmod 777 ftp/install.sh && sudo ./ftp/install.sh && chmod 777 wordpress/install.sh && chmod 777 wordpress/uninstall.sh && chmod 777 wordpress/reinstall.sh && ./wordpress/install.sh;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac