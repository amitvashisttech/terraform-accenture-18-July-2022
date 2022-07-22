resource "aws_instance" "dev-app" { 
  #ami = data.aws_ami.myami.id
  ami = "ami-052efd3df9dad4825"
  instance_type = lookup(var.instance_type, terraform.workspace) 
  #key_name = var.key_name
  availability_zone = "us-east-1a"
  #vpc_security_group_ids = [var.sg_id]
  tags = { 
    Name = local.default_name
  }

}

resource "aws_ebs_volume" "my-vol" { 
  availability_zone = "us-east-1a"
  size = 40

  tags = {
    Name = "my-vol-ebs"
   }

}


resource "aws_volume_attachment" "ebs_att" {
   device_name = "/dev/sdh"
   volume_id   = aws_ebs_volume.my-vol.id
   instance_id = aws_instance.dev-app.id
}

