variable "owner" {
    type = string
    default = "bokhanych"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "allow_ports" {
    type = list
    default = ["80", "443", "22"]
  
}

variable "common_tags" {
  type = map
  default = {
    "Owner" = "bokhanych"
  }
}