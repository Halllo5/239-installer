#!/bin/bash


#It just runs the APT Command to Install Apache BRO
sudo apt install -y apache2

#And Gives The Apropriet Rights
sudo chmod -R g+s /var/www
sudo chmod -R 777 /var/www