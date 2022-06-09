§#Chck if MySQL and WordPress CLI is installed
if ! command -v apache2 &> /dev/null
then
    echo "Apache coud not be found let me try to install it"
    sudo apt update
    sudo apt install apache2
fi
if ! command -v mysql &> /dev/null
then
    echo "MySQL coud not be found let me try to install it"
    sudo apt update
    sudo apt install mysql-server
fi
if ! command -v php &> /dev/null
then
    echo "PHP coud not be found let me try to install it"
    sudo apt update
    sudo apt install php libapache2-mod-php php-mysql
fi
if ! command -v wp &> /dev/null
then
    echo "WP CLI coud not be found let me try to install it"
    sudo apt update
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    php wp-cli.phar --info
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
fi
#Deactivate MySQL PW Policy
sudo mysql < sql/nopolicy.sql

read -p "Are you sure? " -n 1 -r
echo  Install phpmyadmin
if [[$REPLY =~ ^[Yy]$ ]]
then
apt-get install mcrypt

service apache2 restart

apt-get install phpmyadmin

(cd /var/www/html; ln -s /usr/share/phpmyadmin)
fi
chmod 777 wordpress/install.sh
chmod 777 wordpress/uninstall.sh
chmod 777 wordpress/reinstall.sh
./wordpress/install.sh