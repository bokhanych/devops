#!/bin/bash 
yum -y update
yum -y install httpd
cat <<EOF > /var/www/html/index.html
<html>
<h1>
Hello world by ${first_name} ${last_name}!
</h1>
<h2>
Who is ${user} without closes? <br><br>
%{ for x in roles ~}
${x}! <br>
%{ endfor ~}
</h2>
</html>
EOF

sudo service httpd start
chkconfig httpd on
