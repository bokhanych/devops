resource "aws_instance" "webserver" {
    ami = "ami-0a261c0e5f51090b1"
    instance_type = "t2.micro"
    tags = {
      "Name" = "Web Server",
      "Owner" = "bokhanych"
    }
    vpc_security_group_ids = [aws_security_group.webserver.id]
    user_data = file ("user_data.sh")
}

resource "aws_security_group" "webserver" {
  name = "dynamic security group"
  tags = {
    "Name" = "Web Server security group"
    "Owner" = "bokhanych"
  }

dynamic "ingress" {
  for_each = ["80", "443", "8080", "8081"]
  content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "10.10.0.0/16" ]
  }

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]    
  }
  
}