resource "aws_instance" "webserver" {
    ami = "ami-0a261c0e5f51090b1"
    instance_type = "t2.micro"
    tags = {
      "Name" = "Web Server",
      "Owner" = "bokhanych"
    }
    vpc_security_group_ids = [aws_security_group.webserver.id]
    user_data = <<EOF
#!/bin/bash 
yum -y update
yum -y install httpd
echo "<h2>Hello world!</h2>" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
}

resource "aws_security_group" "webserver" {
  name = "webserver security group"
  tags = {
    "Name" = "Web Server security group"
    "Owner" = "bokhanych"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]    
  }
  
}