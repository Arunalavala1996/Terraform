provider "aws" {
  region = "ap-south-1"
  
}

variable "ami_id" {
  description = "value of the ami id"
  type = string
  
}

variable "instance_type" {
  description = "value of the instance type"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "prod" = "t2.large"
    "stage" = "t2.medium"
  }  
}


module "ec2_instance" {
  source = "./module/ec2_instance"
  ami_id = var.ami_id
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}