provider "aws" {
  region = "us-east-1"
}



provider "aws" {
  region = "us-west-1"
  alias = "myregion"
}

resource "aws_instance" "front" { 
 ami = "ami-0cff7528ff583bf9a"
 instance_type = "t2.micro"

 tags = { 
   Name = "HelloWorld"
 } 
}



resource "aws_instance" "back" { 
 ami = "ami-0d9858aa3c6322f73"
 instance_type = "t2.micro"
 provider = aws.myregion
 tags = { 
   Name = "HelloWorld"
 } 
}
