provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer"
  }
}



resource "aws_instance" "db" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"

  tags = {
    Name = "DBServer"
  }
}
