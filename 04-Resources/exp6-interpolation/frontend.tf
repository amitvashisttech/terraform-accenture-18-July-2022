resource "aws_instance" "frontend" {
  count = 2 
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  tags = { 
    Name = "FrontEnd-${count.index +1}"
  }
}
