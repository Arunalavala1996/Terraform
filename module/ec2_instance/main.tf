provider "aws" {
  region = "ap-south-1"
  
}

variable "ami_id" {
  description = "value of the ami id"
  type = string
  
}

variable "instance_type" {
  description = "value of the instance type"
  type = string
}

resource "aws_instance" "myec2" {
  ami = var.ami_id
  instance_type = var.instance_type
}