#!/bin/bash 
yum -y update
yum -y install httpd
echo "<h2>Hello world!</h2>" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
