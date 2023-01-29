variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "frontend_ports" {
    type = list
    default = ["22", "80", "443"]
}

variable "backend_ports" {
    type = list
    default = ["22", "8080"]
}