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


#Edit Premmisions of all Files
chmod 777 uninstall239.sh
chmod 777 wordpress/install.sh
chmod 777 wordpress/uninstall.sh
chmod 777 wordpress/cli/install.sh
chmod 777 sql/install.sh
chmod 777 sql/uninstall.sh
chmod 777 phpMyAdmin/install.sh
chmod 777 phpMyAdmin/uninstall.sh
chmod 777 ftp/install.sh
chmod 777 ftp/uninstall.sh
chmod 777 apache/install.sh
chmod 777 apache/uninstall.sh
chmod 777 apache/php/install.sh
chmod 777 apache/php/uninstall.sh




#Updates so no other scripts need to do it
sudo apt update

#Check if APT is installed
if ! command -v apt &> /dev/null
then
    echo "APT Could not be found"
    echo "Be sure to install APT or use a Linux Disto wich has it installed by default"
    echo "This script was only testet on Ubuntu Server 22.04 LTS (Raspberry Pi 4B 8GB)"
    echo "Bye bye"

    exit
fi
#Install Apache
(cd ..; ./apache/install.sh)
#Install MySQL
(cd ..; ./sql/install.sh)
#Install PHP
(cd ..; ./apache/php/install.sh)
#Install the WP CLI
(cd ..; ./wordpress/cli/install.sh) 


#Deactivate MySQL PW Policy
sudo mysql < sql/nopolicy.sql

echo "!!! Do you want to install phpMyAdmin (Recomended) otherwies you will have to create a MySQL Account with all rights by yourself !!!"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed && ./phpMyAdmin/install.sh && ./wordpress/install.sh && sudo ./ftp/install.sh ;;
	no ) echo Installing with advanced mode... && ./wordpress/install.sh && sudo ./ftp/install.sh;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac