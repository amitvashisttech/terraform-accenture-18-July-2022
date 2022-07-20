provider "aws" {
  region = "us-east-1"
}

variable "zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

resource "aws_instance" "web" {
  count = 2 
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  availability_zone = var.zones[count.index]
}

output "public_ips" { 
  value = aws_instance.web.*.public_ip
}


output "private_ips" { 
  value = aws_instance.web.*.private_ip
}



output "private_ips_of_first_instance" { 
  value = aws_instance.web.0.private_ip
}
