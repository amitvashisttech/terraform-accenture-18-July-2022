variable "region" { 
  default = "us-east-1" 
}

locals { 
  default_name = "${join("-", tolist([terraform.workspace, "example"]))}"
}


variable "instance_type" { 
 type = map 
 default = { 
   default = "t2.nano"
   dev     = "t2.micro"
   prod    = "t2.large"
 }
}

variable "instance_count" { 
  type = map 
  default = { 
   default = "1"
   dev = "2"
   prod = "3"
  }
}

variable "key_name" { 
  default = "terraform-key-acc-21-July-2022"
}

variable "pvt_key" { 
  default = "/home/amit/.my-pvt-aws.pem"
}

variable "sg_id" { 
  default = "sg-075b3f165420caf90"
}
