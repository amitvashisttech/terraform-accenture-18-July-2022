provider "aws" {
  version = "3.20"
  region  = "us-east-1"
}


provider "aws" {
  version = "3.20"
  region  = "us-west-1"
  alias   = "us-west-2"
}

/*
variable "zones_east" {
  default = ["us-east-2a", "us-east-2b"]
}

variable "zones_west" {
  default = ["us-west-2a", "us-west-2c"]
}
*/ 


data "aws_availability_zones" "zone_east" {}
data "aws_availability_zones" "zone_west" {
   provider = aws.us-west-2
}

data "aws_ami" "myami_east" {
  most_recent = true
  owners = ["amazon"]

 filter {
  name = "name"
  values = ["amzn2-ami-hvm*"]
  }

}

data "aws_ami" "myami_west" {
  provider = aws.us-west-2
  most_recent = true
  owners = ["amazon"]

 filter {
  name = "name"
  values = ["amzn2-ami-hvm*"]
  }

}






variable "multi-region-deployment" {
  default = true
}

variable "project-name" {
  default = "Terraform-Demo"
}

variable "project-name-2" {
  default = "Test-Demo"
}

locals {
  default_frontend_name = join("-", tolist([var.project-name, "Frontend"]))
  default_backend_name  = join("-", tolist([var.project-name, "Backend"]))
  west_frontend_name    = join("-", tolist([var.project-name-2, "Frontend"]))
  west_backend_name     = join("-", tolist([var.project-name-2, "Backend"]))
}

locals {
  some_tags = {
    Owner   = "DevOps Team"
    Project = "Demo DevOps Project"
    Server  = "Backend"
    Name    = local.west_backend_name
  }
}




resource "aws_instance" "east_frontend" {
  ami               = data.aws_ami.myami_east.id
  availability_zone = data.aws_availability_zones.zone_east.names[count.index]
  count             = 2
  instance_type     = "t2.micro"
  depends_on        = [aws_instance.east_backend]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    #Name = "${join("-", tolist([var.project-name, "Frontend"]))}-${count.index + 1}"
    Name = local.default_frontend_name
  }
}

resource "aws_instance" "west_frontend" {
  ami               = data.aws_ami.myami_west.id
  availability_zone = data.aws_availability_zones.zone_west.names[count.index]
  instance_type     = "t2.micro"
  count             = var.multi-region-deployment ? 2 : 0
  depends_on        = [aws_instance.west_backend]
  provider          = aws.us-west-2
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = local.west_frontend_name
  }
}


resource "aws_instance" "east_backend" {
  ami               = data.aws_ami.myami_east.id
  availability_zone = data.aws_availability_zones.zone_east.names[count.index]
  instance_type     = "t2.micro"
  count             = 2
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = local.default_backend_name
  }

}


resource "aws_instance" "west_backend" {
  ami               = data.aws_ami.myami_west.id
  availability_zone = data.aws_availability_zones.zone_west.names[count.index]
  instance_type     = "t2.micro"
  count             = var.multi-region-deployment ? 2 : 0
  provider          = aws.us-west-2
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
  value = concat(aws_instance.east_backend.*.tags.Name, aws_instance.east_frontend.*.tags.Name)
}

