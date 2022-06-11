#!/bin/bash

#Install php
sudo apt install php libapache2-mod-php php-mysql

#Enable/disable modules
sudo a2dismod mpm_event && sudo a2enmod mpm_prefork && sudo a2enmod php7.0

#Modify the .conf file
(sudo cat /etc/apache2/apache2.conf; echo "<FilesMatch \.php$> 
SetHandler application/x-httpd-php 
​</FilesMatch>") >> /etc/apache2/apache2.conf

#Restart Apache
sudo service apache2 restart