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
chmod 755 uninstall239.sh
chmod 755 wordpress/install.sh
chmod 755 wordpress/uninstall.sh
chmod 755 wordpress/cli/install.sh
chmod 755 sql/install.sh
chmod 755 sql/uninstall.sh
chmod 755 phpMyAdmin/install.sh
chmod 755 phpMyAdmin/uninstall.sh
chmod 755 ftp/install.sh
chmod 755 ftp/uninstall.sh
chmod 755 apache/install.sh
chmod 755 apache/uninstall.sh
chmod 755 apache/php/install.sh
chmod 755 apache/php/uninstall.sh
chmod 755 msmtp/install.sh




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
./apache/install.sh
#Install MySQL
./sql/install.sh
#Install PHP
./apache/php/install.sh
#Install the WP CLI
./wordpress/cli/install.sh


#Deactivate MySQL PW Policy
sudo mysql < sql/nopolicy.sql

echo "!!! Do you want to install phpMyAdmin (Recomended) otherwies you will have to create a MySQL Account with all rights by yourself !!!"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo "ok, installing phpMyAdmin..." && ./phpMyAdmin/install.sh && ./msmtp/install.sh && ./wordpress/install.sh && sudo ./ftp/install.sh ;;
	no ) echo "Installing in advanced mode (no phpMyAdmin)..." && ./msmtp/install.sh && ./wordpress/install.sh && sudo ./ftp/install.sh;
		exit;;
	* ) echo "Invalid Response Please Re-Run the Script";
        echo "exiting...."
		exit 1;;
esac