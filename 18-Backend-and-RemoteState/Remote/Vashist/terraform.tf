terraform {
  backend "azurerm" {
    resource_group_name  = "tstate"
    storage_account_name = "tstate13637"
    container_name       = "tfstate"
    key                  = "amitvashist.terraform.tfstate"
  }
}




# AWS S3 Bucket as Storage Backend
/*
terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-av"
    key    = "terraform-backend-av/terraform.tfstate"
    region = "us-west-2"
  }
}

*/
