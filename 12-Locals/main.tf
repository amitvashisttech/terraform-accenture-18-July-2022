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
  default = true
}

variable "project-name" {
  default = "DevOps-TF-East"
}



variable "project-name-2" {
  default = "Terraform-West"
}

locals { 
  east_frontend_name = join("-", tolist([var.project-name, "Frontend"]))
  east_backend_name  = join("-", tolist([var.project-name, "Backend"]))
  west_frontend_name = join("-", tolist([var.project-name-2, "Frontend"]))
  west_backend_name  = join("-", tolist([var.project-name-2, "Backend"]))
}

locals { 
  some_tags = { 
    Owner = "DevOps Team" 
    Project = "POC DevOps Terraform Project" 
    Server = "Backend"
    Name   = local.west_backend_name

 }
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
    #Name = "${join("-", tolist([var.project-name, "East-Frontend"]))}-${count.index + 1}"
    Name = local.east_frontend_name
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
    #Name = "${join("-", tolist([var.project-name, "West-Frontend"]))}-${count.index + 1}"
    Name = local.west_frontend_name
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
    #Name = "${join("-", tolist([var.project-name, "East-Backend"]))}-${count.index + 1}"
    Name = local.east_backend_name
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
  tags = local.some_tags
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
