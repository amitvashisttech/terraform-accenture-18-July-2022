provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  count = 2 
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  availability_zone = var.zones[count.index]
  
  tags = {
    Name = "${join("-", tolist([var.myname]))}-${count.index}"
  }
 
}

