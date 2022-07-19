terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.63.0, <=3.65.0"
    }
  }
}



provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "front" { 
 ami = "ami-0cff7528ff583bf9a"
 instance_type = "t2.micro"

 tags = { 
   Name = "HelloWorld"
 } 
}
