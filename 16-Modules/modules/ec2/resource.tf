resource "aws_instance" "instance" {
  ami               = data.aws_ami.myami.id
  instance_type     = var.type
  count             = var.ec2_count
  tags = { 
    Name = "My-Test-Instance-${count.index}"
  }
}
