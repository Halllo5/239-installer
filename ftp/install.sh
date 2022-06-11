#!/bin/bash

#Name of Script
echo "███████ ████████ ██████      ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████  ";
echo "██         ██    ██   ██     ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██ ";
echo "█████      ██    ██████      ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████  ";
echo "██         ██    ██          ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██ ";
echo "██         ██    ██          ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██ ";
echo "                                                                                                   ";
echo "                                                                                                   ";

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


#Gather Info

    #Gather Username
echo "What shoud the FTP account be (default: websrv_user) "
read USERNAME
USERNAME="${USERNAME:=websrv_user}"
    #Gather User PW
echo "What PAssword shoud the FTP Account have (has to be entert once again later |default: websrv_user) "
read PW
PW="${PW:=websrv_user}"

 #Install Prod FTP
 sudo apt -y install proftpd

 #Add User
 (cd /etc/proftpd/; sudo ftpasswd --passwd ${PW} --name ${USERNAME} --gid 33 --uid 33 --home /var/www/ --shell /bin/false)
 

#Edit cofig
(sudo cat /etc/proftpd/proftpd.conf; echo "DefaultRoot ~
AuthOrder mod_auth_file.c mod_auth_unix.c
AuthUserFile /etc/proftpd/ftpd.passwd
AuthPAM off
RequireValidShell off"
) >> /etc/proftpd/proftpd.conf


#Restart FTP 
sudo /etc/init.d/proftpd restart


#SFTP 
    #INstall Crypto
#sudo apt install proftpd-mod-crypto

#Edit Modules File

#sudo sed -i '/ mod_tls.c /s/^/#/' /etc/proftpd/modules.conf
#sudo sed -i '/ mod_tls_fscache.c /s/^/#/' /etc/proftpd/modules.conf
#sudo sed -i '/ mod_tls_shmcache.c /s/^/#/' /etc/proftpd/modules.conf

#Cert Erstellen
#sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt -nodes -days 365

#Add Config
#sudo touch /etc/proftpd/conf.d/tls.conf
#(sudo cat /etc/proftpd/conf.d/tls.conf; echo "<IfModule mod_tls.c>
# TLSEngine on
# TLSLog /var/log/proftpd/tls.log
# TLSProtocol TLSv1.3
# TLSRSACertificateFile /etc/ssl/certs/proftpd.crt
# TLSRSACertificateKeyFile /etc/ssl/private/proftpd.key
# TLSVerifyClient off
#TLSOptions NoSessionReuseRequired
# TLSRequired on
#</IfModule>") > /etc/proftpd/conf.d/tls.conf

#Restart Service 
#sudo /etc/init.d/proftpd restart