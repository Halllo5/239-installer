#!/bin/bash

#Ask if user knows if the have information abaiut mail server
#Ask if FTP already installed
read -p "Do you have information about your E-mail server ore use G-Mail(yes/no) " yn

case $yn in 
	yes | Y | y ) echo ok, we will proceed;
        INSTALL="1";;
	no | N | n) echo "Installation done";
		INSTALL="0";;
	* ) echo invalid response;
		INSTALL="0";;
esac

if [ $INSTALL = 1 ]; then
#Install it 
sudo apt install -y msmtp msmtp-mta
#Get info from user
    #Ask E-Mail
echo "What E-Mail adress do you want to use"
read EMAIL
    #Ask E-Mail
echo "What E-Mail adress do you want to use as admin (Errors will be sent there) default: your E-Mail"
read AEMAIL
AEMAIL="${AEMAIL:=$EMAIL}"
    #Ask SMPT HOST
echo "What is the SMTP host (default: smtp.gmail.com [G-mail SMPT Server])"
read HOST
HOST="${HOST:=smtp.gmail.com}"
    #Ask USername
echo "What is the username for the E-Mail (default: your E-mail)"
read USERNAME
USERNAME="${USERNAME:=$EMAIL}"
    #Ask PW
echo "What is the Password for your E-Mail"
echo "Warning if you use G-Mail or Icloud you need to generate a specifc Password"
echo "https://support.google.com/accounts/answer/6010255?hl=de"
echo "https://support.apple.com/en-us/HT204397"
read PASSW

#Generate /etc/msmtprc
sudo touch /etc/msmtprc
sudo echo "# Set default values for all following accounts.
defaults
# Use the mail submission port 587 instead of the SMTP port 25.
port 587
# Always use TLS.
tls on
# Set a list of trusted CAs for TLS. The default is to use system settings, but
# you can select your own file.
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account $EMAIL
# Host name of the SMTP server
host $HOST
from $EMAIL
# Authentication. The password is given using one of five methods, see below.
auth on
user $USERNAME
password $PASSW
account default: $EMAIL
# Map local users to mail addresses (for crontab)
aliases /etc/aliases
" >> /etc/msmtprc
#Change Premmision
sudo chmod 600 /etc/msmtprc

#Generate  /etc/aliases
sudo touch /etc/aliases
sudo echo "root: $AEMAIL
default: $AEMAIL" >> /etc/aliases

#Send Test E-Mail
echo "This email was automatically generated from the 239 installer script
https://github.com/Halllo5/239-installer
If you received this email, it means that the email was configured correctly. 
You can now send emails using the following commands 
sudo su
echo "Your message" | msmtp recipient@adresse.com" | sudo msmtp $AEMAIL
echo "A test E-Mail has been sent to your admin E-Mail if you recive this E-Mail it means that it was configured corectly"

echo "Warning If you want to use php to send mails please refere to the README"
echo"https://github.com/Halllo5/239-installer#readme"
fi