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
#Uninstall MySQL Server
sudo apt purge mysql-server