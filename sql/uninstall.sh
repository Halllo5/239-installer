#!/bin/bash

echo "██████  ██████      ██████  ███████ ██      ███████ ████████ ███████ ██████  ";
echo "██   ██ ██   ██     ██   ██ ██      ██      ██         ██    ██      ██   ██ ";
echo "██   ██ ██████      ██   ██ █████   ██      █████      ██    █████   ██████  ";
echo "██   ██ ██   ██     ██   ██ ██      ██      ██         ██    ██      ██   ██ ";
echo "██████  ██████      ██████  ███████ ███████ ███████    ██    ███████ ██   ██ ";
echo "                                                                             ";
echo "                                                                             ";
#Drop WP DB
sudo mysql < uninstall.sql
sudo mysql < sql/uninstall.sql
#Uninstall MySQL Server
sudo apt -y purge mysql-server