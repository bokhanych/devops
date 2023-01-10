resource "aws_instance" "webserver1" {
    ami = "ami-0a261c0e5f51090b1"
    instance_type = var.instance_type
    tags = merge(var.common_tags, { Name = Webserver1 })    # Variables
    vpc_security_group_ids = [aws_security_group.webserver.id]
    user_data = templatefile ("user_data.tpl", {   # Templates
      first_name = "Dmitry",
      last_name = "Bakhanko",
      user = "Shpil",
      roles = ["genius", "milliarder", "playboy", "filantrop"]
    })
}

resource "aws_instance" "webserver2" {
    ami = "ami-0a261c0e5f51090b1"
    instance_type = var.instance_type
    #tags = var.common_tags
    tags = merge(var.common_tags, { Name = Webserver2 })
    vpc_security_group_ids = [aws_security_group.webserver.id]
    user_data = file ("user_data.sh") # User Data 
}

provider "aws" {}
data "aws_availability_zones" "zone_names" {} # Data Source
output "data_aws_availability_zones" {
  value = data.aws_availability_zones.zone_names.names
}
data "aws_caller_identity" "my_account_id" {}
output "aws_caller_identity" {
  value = data.aws_caller_identity.my_account_id.account_id
}
data "aws_region" "current" {}
output "data.aws_region" {
  value = data.aws_region.current.name
}
output "data.aws_region" {
  value = data.aws_region.current.description
}

dynamic "ingress" {
  for_each = var.allow_ports  # Dynamic security blocks
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