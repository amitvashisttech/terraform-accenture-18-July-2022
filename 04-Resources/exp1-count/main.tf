provider "aws" {
  region = "us-east-1"
  # Note: Please don't use this section for AWS Keys, this is only of ref. 
  # access_key = "XXXXXXX"
  # secret_key = "YYYYYYY"
}

resource "aws_instance" "web" {
  count = 1 
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
}

