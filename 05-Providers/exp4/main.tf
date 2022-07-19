provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "front" { 
 ami = "ami-0cff7528ff583bf9a"
 instance_type = "t2.micro"

 tags = { 
   Name = "HelloWorld"
 } 
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-RG"
  location = "West Europe"
 
 tags = { 
   Name = "HelloWorld-Azure-RG"
   Owner = "Amit Vashist"
   Project = "IAC"
   Team   = "DevOps" 
 } 
}
