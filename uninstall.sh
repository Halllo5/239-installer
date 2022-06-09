#!/bin/bash
sudo mysql < sql/uninstall.sql
echo "Where is wordpress installed (/var/www/html/What you need to enter)"
read LOCATION
sudo rm -r /var/www/html/${LOCATION}