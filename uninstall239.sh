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
  y|Y ) echo "Starting script ...." && ./apache/php/uninstall.sh && ./apache/uninstall.sh && ./ftp/uninstall.sh && ./phpMyAdmin/uninstall.sh && ./sql/uninstall.sh && ./wordpress/uninstall.sh;;
  n|N ) echo "You have canceled the script, your data should be safe ";;
  * ) echo "Invalid input (probably better, think again if you really want to delete everything)";;
esac
echo "All things uninstalled only the WordPress CLI is remaining"