provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  count = 1 
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
}

