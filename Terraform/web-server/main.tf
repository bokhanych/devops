resource "aws_instance" "frontend" {
    ami = data.aws_ami.latest_ubuntu.id
    instance_type = var.instance_type
    tags = { Name = "frontend1" }
    vpc_security_group_ids = [aws_security_group.frontend_security_group.id]
}

resource "aws_instance" "backend" {
    ami = data.aws_ami.latest_ubuntu.id
    instance_type = var.instance_type
    count = 2
    tags = { Name = "backend${count.index}" }
    vpc_security_group_ids = [aws_security_group.backend_security_group.id]
}

resource "aws_security_group" "frontend_security_group" {
  name = "Frontend Security Group"
  description = "Open SSH, HTTP, HTTPS port"

    dynamic "ingress" {
    for_each = var.frontend_ports
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]    
    }
}

resource "aws_security_group" "backend_security_group" {
  name = "Backend Security Group"
  description = "Open SSH, Java port"
    depends_on = [ aws_security_group.frontend_security_group ]
    dynamic "ingress" {
    for_each = var.backend_ports
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        security_groups = [aws_security_group.frontend_security_group.id]
    }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]    
    }
}