# 239 Installer

239 Installer is a collection of simple scripts to install a wordpress site following the guidelines of [239 Module](https://bbz.macherit.ch/m239_main/).

---

## Know Issues


**phpMyAdmin and WordPress do not work with a reverse proxy at the moment**



---

## How to install

If you **know a little what you are doing** and are not easily confused, you can **simply clone this repo** and run the `install239.sh script`
**Below you will find a more detailed description**

### Detailed description

1. First you have to clone this repo (for this git has to be installed on the target machine)
  
2. Then change to the directory and edit the permissions first so that it can be executed, and then run the script (as shown below)
  

```bash
git clone https://github.com/Halllo5/239-installer.git




cd 239-installer



chmod 755 installer239.sh




./installer239.sh
```

3. After you start the script, you must first enter the password for your account (which must have sudo permissions), because some things must be run as sudo
  
4. First you will be asked if you want to install phpMyAdmin, which is **highly recommended**, otherwise you will have to create a **MySQL account yourself** with the right permissions and run the script again
  
5. Then phpMyAdmin is installed first (you can ignore this step if you don't want to install it)
  
6. First you should be asked which web server you want to use, choose `apache2`(we installed it automatically earlier if it was not already installed)
  
7. Then it soud ask you if you want to **configure a Database** wich you need to awnser with **yes**
  
8. Then you need to enter a password, which you need to remember because you will need to enter it later for the WordPress installation.

9. [After that it shoud procede with the E-Mail Configuration](#configure-e-mail-msmtp)
  
10. After that the WordPress Installation shoud start
  
11. First you will be asked if you have a DB user, which you can answer in the affirmative if you have installed phpMyAdmin or created one previously
  
12. After that you will be asked for a `DB_User` which you can enter (if you have phpMyAdmin installed this would be `phpmyadmin`)
  
13. After that, you will be asked for a password that you have previously chosen
  
14. Now you will be asked for the location where Wordpress should be installed (it is always located in the `/var/www/html` directory), the default is `wordpress`.

15. The next step requires a URL, which by default is http://localhost (you do not need to enter the location "the / Path", it is automatically derived from the location entered above). Note that I **didnt get wordpress working behind an Nginx reverse proxy**
  
16. After that you will be asked some questions about the configuration of Wordpress (all of which you can change directly in Wordpress after installation)
  
17. Then you will be asked if you want to install **FTP**, which is **highly recommended**.
  
18. When the FTP installer starts, you will be asked for an FTP account, which will be created.
  
19. After FTP is configured, you will be asked if you want to configure **SFTP** (which **requires manual configuration**)
  

---

### SFTP Configuration

1. First you will have to activate the Modules wich you can by removig the comments before the
  
 ```bash
  sudo nano /etc/proftpd/modules.conf
  
  #These lines need to be uncommented 
  LoadModule mod_tls.c 
  LoadModule mod_tls_fscache.c
  LoadModule mod_tls_shmcache.c
  
  ```
  
2. After that you need to add the following lines at the end of the configuration
  

```bash
sudo nano /etc/proftpd/conf.d/tls.conf
```

```
<IfModule mod_tls.c>
 TLSEngine on
 TLSLog /var/log/proftpd/tls.log
 TLSProtocol TLSv1.3
 TLSRSACertificateFile /etc/ssl/certs/proftpd.crt
 TLSRSACertificateKeyFile /etc/ssl/private/proftpd.key
 TLSVerifyClient off
TLSOptions NoSessionReuseRequired
 TLSRequired on
</IfModule>
```

3. And finally restart the FTP server
  

```bash
sudo /etc/init.d/proftpd restart
```
---
## Configure E-Mail (msmtp)
1. If the Script starts you need to enter a few simple questions 
2. Important is here that if your using G-Mail or Icloud you need a app specific password
* Gmail: 
*  -SMPT Host: smtp.gmail.com
*  -App Specific PW: https://support.google.com/accounts/answer/6010255
* Icloud:
*  -SMPT Host: smtp.mail.me.com
*  -App Specific PW: https://support.apple.com/en-us/HT204397


### Configure PHP Mail
1. To configure it, we need to edit the PHP configuration, which we can do as follows.
Note: Your PHP version might be different, which means you need to change the version number in the path below from [8.1] to your version number.
```bash
sudo nano /etc/php/8.1/apache2/php.ini
```
2. Then find the following line and change the configuration so that it is exactly the same
```
[mail function]
; For Win32 only.
;SMTP = localhost
;smtp_port = 25
; For Win32 only.
;sendmail_from = me@example.com
; For Unix only. You may supply arguments as well (default: "sendmail -t -
i").
sendmail_path = "/usr/bin/msmtp -t" 
```
3. And finally restart the web server
```bash
sudo systemctl restart apache2
```
Then everything shoud work
---

#### This is not a complete script, but it should install the basics fairly reliably 