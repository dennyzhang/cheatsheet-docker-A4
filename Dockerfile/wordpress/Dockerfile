########## How To Use Docker Image ###############
##
##  docker image for wordpress
##
##  Install docker utility
##  Download docker image: docker pull denny/wordpress:v1
##  Boot docker container: docker run -t -d -h wordpress --name my-wordpress -p 58080:80 denny/wordpress:v1 /usr/sbin/sshd -D
##
##  sed -i 's/wordpresscn1.dennyzhang.com:80/wordpresscn.dennyzhang.com:58080/g' /root/mysql-dennywordpress.sql
##  mysql -uwordpress -poscWORDPRESS2015 dennywordpress < /root/mysql-dennywordpress.sql
##
##  service mysql start
##  service apache2 start
##
##  http://$server_ip:58080
##################################################

FROM ubuntu:14.04
MAINTAINER DennyZhang.com <http://dennyzhang.com>

########################################################################################
apt-get update
apt-get install -y apache2 php5 libapache2-mod-php5 php5-mysql
apt-get install -y mysql-server

# enable Apache modules
service apache2 restart
a2enmod proxy proxy_http rewrite headers authz_groupfile cgid
service apache2 restart

# checkout Apache vhost
cd /var/www/
git clone https://dennyzhang001@bitbucket.org/dennyzhang001/denny_wordpress.git
chown www-data:www-data -R /var/www/denny_wordpress

# create mysql db
service mysql start
mysql -u root -p

CREATE USER wordpress@localhost IDENTIFIED BY "CHANGEYOURPASSWORD";
create database dennywordpress;
GRANT ALL ON dennywordpress.* TO wordpress@localhost;
FLUSH PRIVILEGES;
exit

# inject db from exported mysql file
mysql -uwordpress -poscWORDPRESS2015 dennywordpress < /tmp/mysql-dennywordpress.sql
rm -rf /tmp/mysql-dennywordpress.sql

# define Apache vhost
vim /etc/apache2/sites-enabled/denny-wordpress.conf
service apache2 restart

# vhost update
sed -i 's/ServerName www.dennyzhang.com/#ServerName www.dennyzhang.com/g' /etc/apache2/sites-enabled/denny-wordpress.conf
########################################################################################
