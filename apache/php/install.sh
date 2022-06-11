#!/bin/bash

#Install php
sudo apt -y install php libapache2-mod-php php-mysql

#Enable/disable modules
sudo a2dismod mpm_event && sudo a2enmod mpm_prefork 

#Modify the .conf file
(sudo cat /etc/apache2/apache2.conf; echo "<FilesMatch \.php$> 
SetHandler application/x-httpd-php 
​</FilesMatch>") >> /etc/apache2/apache2.conf

#Restart Apache
sudo service apache2 restart