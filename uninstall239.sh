#!/bin/bash

#Script Logo
echo "██████  ██████   █████      ██    ██ ███    ██ ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████  ";
echo "     ██      ██ ██   ██     ██    ██ ████   ██ ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██ ";
echo " █████   █████   ██████     ██    ██ ██ ██  ██ ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████  ";
echo "██           ██      ██     ██    ██ ██  ██ ██ ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██ ";
echo "███████ ██████   █████       ██████  ██   ████ ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██ ";
echo "                                                                                                                     ";
echo "                                                                                                                     ";

#Are you Sure
echo "This is going to Delete Wordpress MySQL and FTP"
echo "If you continue all your data will be lost be sure to keep a backup"
echo "Please be careful with this command (it will delet your DataBase)"
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "Starting script ...." && sudo apt purge apache2 && sudo apt purge mysql-server && sudo apt purge php libapache2-mod-php php-mysql && chmod 777 wordpress/uninstall.sh && ./wordpress/uninstall.sh;;
  n|N ) echo "You have canceled the script, your data should be safe ";;
  * ) echo "Invalid input (probably better, think again if you really want to delete everything)";;
esac