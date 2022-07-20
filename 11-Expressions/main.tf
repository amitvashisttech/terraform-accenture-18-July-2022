provider "aws" {
  version = "3.20"
  region  = "us-east-1"
}


provider "aws" {
  version = "3.20"
  region  = "us-west-1"
  alias   = "us-west-1"
}

variable "zones_east" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "zones_west" {
  default = ["us-west-1b", "us-west-1c"]
}


variable "multi-region-deployment" {
  default = false
}

variable "project-name" {
  default = "DevOps-TF-Demo"
}

resource "aws_instance" "east_frontend" {
  ami               = "ami-0cff7528ff583bf9a"
  instance_type     = "t2.micro"
  availability_zone = var.zones_east[count.index]
  count             = 2
  depends_on        = [aws_instance.east_backend]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${join("-", tolist([var.project-name, "East-Frontend"]))}-${count.index + 1}"
  }

}

resource "aws_instance" "west_frontend" {
  ami               = "ami-0d9858aa3c6322f73"
  instance_type     = "t2.micro"
  availability_zone = var.zones_west[count.index]
  depends_on        = [aws_instance.west_backend]
  provider          = aws.us-west-1
  # Contitions 
  count = var.multi-region-deployment ? 2 : 0
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "${join("-", tolist([var.project-name, "West-Frontend"]))}-${count.index + 1}"
  }
}


resource "aws_instance" "east_backend" {
  ami               = "ami-0cff7528ff583bf9a"
  instance_type     = "t2.micro"
  availability_zone = var.zones_east[count.index]
  count             = 2
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "${join("-", tolist([var.project-name, "East-Backend"]))}-${count.index + 1}"
  }
}


resource "aws_instance" "west_backend" {
  ami               = "ami-0d9858aa3c6322f73"
  instance_type     = "t2.micro"
  availability_zone = var.zones_west[count.index]
  # Contitions 
  count    = var.multi-region-deployment ? 2 : 0
  provider = aws.us-west-1
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "${join("-", tolist([var.project-name, "West-Backend"]))}-${count.index + 1}"
  }
}

output "PublicIP_East_Frontend" {
  value = aws_instance.east_frontend.*.public_ip
}

output "PublicIP_East_Backend" {
  value = aws_instance.east_backend.*.public_ip
}


output "tag_name" { 
   value = concat(aws_instance.east_frontend.*.tags.Name, aws_instance.west_frontend.*.tags.Name, aws_instance.east_backend.*.tags.Name, aws_instance.west_backend.*.tags.Name)
}
