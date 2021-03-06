#!/bin/bash

#Name of Script 
echo "██     ██  ██████  ██████  ██████  ██████  ██████  ███████ ███████ ███████     ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████  ";
echo "██     ██ ██    ██ ██   ██ ██   ██ ██   ██ ██   ██ ██      ██      ██          ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██ ";
echo "██  █  ██ ██    ██ ██████  ██   ██ ██████  ██████  █████   ███████ ███████     ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████  ";
echo "██ ███ ██ ██    ██ ██   ██ ██   ██ ██      ██   ██ ██           ██      ██     ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██ ";
echo " ███ ███   ██████  ██   ██ ██████  ██      ██   ██ ███████ ███████ ███████     ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██ ";
echo "                                                                                                                                                     ";


#Chck if MySQL and WordPress CLI is installed
if ! command -v mysql &> /dev/null
then
    echo "MySQL coud not be found try installing it and try again"
    echo "bye se you soon"
    exit
fi
if ! command -v wp &> /dev/null
then
    echo "WordPress CLI coud not be foud try installing it and try again"
    echo "https://wp-cli.org/"
    echo "bye se you soon"
    exit
fi
#Ask if phpMyAdmin or MySQL account 
read -p "Do you have phpMyAdmin installed or already created a MySQL Account (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo "Please create a MySQL account or re-run the installer and install phpMyAdmin";
		exit;;
	* ) echo invalid response;
		exit 1;;
esac
#questions to get infos for the wordpress instance
    #Ask DB_USER
echo "What is the MySQL_DB User to use with the wordpress DB wich will be created (REQUIERD) "
read DB_USER
    #ASK PW For the DB_USER
echo "What is the Password for the MySQL User (REQUIERD)"
read DB_PW
  #Ask Wordpress Location 
echo "what is the Location for the wordpress Site (/var/www/html/"what you need to enter") (default: wordpress)"
read LOCATION
LOCATION="${LOCATION:=wordpress}"
    #Ask Wordpress URL
echo "what is the url for the wordpress Site (Without the location ) (default: http://localhost)"
read URL
URL="${URL:=http://localhost}"
URL="$URL/$LOCATION"

    #Ask Title for WP Site
echo "What shoud be the title of the WordPress Site (default: My_WP_Site)" 
read WP_Title
WP_Title="${WP_Title:=My_WP_Site}"
    #Ask for WordPress admin user
echo "What shoud be the username of the (default: admin)"
read -p WP_USER
WP_USER="${WP_USER:=admin}"
    #ASK for WordPress admin PW
echo "What shoud be the Passowrd for the WorpdPress admin user (default: admin)"
read -sp WP_PW
WP_PW="${WP_PW:=admin}"
    #ASK for WordPress admin E-Mail
echo "What is the the E-Mail for the WordPress admin User(default: changeme@example.com)"
read WP_EMAIL
WP_EMAIL="${WP_EMAIL:=changeme@example.com}"

#MySQL Install command
sudo mysql < install.sql
sudo mysql < yesphpmyadmin.sql
sudo mysql < wordpress/install.sql
sudo mysql < wordpress/yesphpmyadmin.sql

#WP CLI
    #MKDIR LOCATION

mkdir /var/www/html/${LOCATION}
sudo chmod -R g+s /var/www/html/${LOCATION}
sudo chmod -R 777 /var/www/html/${LOCATION}
    #Donwload WordPress
(cd /var/www/html/${LOCATION}; wp core download)

    #Configure wordpress DB
(cd /var/www/html/${LOCATION}; wp core config --dbhost=localhost --dbname=wordpress --dbuser=${DB_USER} --dbpass=${DB_PW})

    #Chmod KA

sudo chmod 644 /var/www/html/${LOCATION}/wp-config.php

    #Install WordPress
(cd /var/www/html/${LOCATION}; wp core install --url=${URL} --title=${WP_Title} --admin_name=${WP_USER} --admin_password=${WP_PW} --admin_email=${WP_EMAIL})

#WordPress is UP
echo "Wordpress shoud be listening on http://$URL"

#Ask if FTP already installed
read -p "Do you want to install FTP (recomended) (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed;;
    y ) echo ok, we will proceed;;    
    Y ) echo ok, we will proceed;;
	no ) echo "Installation done";
		exit;;
    n ) echo "Installation done";
		exit;;    
    N ) echo "Installation done";
		exit;;
	* ) echo invalid response;
		exit 1;;
esac
