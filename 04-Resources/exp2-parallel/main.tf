provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "frontend" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
}


resource "aws_instance" "backend" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
}
