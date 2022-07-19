provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  # Amazon Linux Image
  ami           = "ami-0cff7528ff583bf9a"

  # Ubuntu 22.04 Linux Image 
  #ami = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"

  lifecycle { 
   prevent_destroy = false
  }

  tags = {
    Name = "HelloWorld"
  }
  
  
}
