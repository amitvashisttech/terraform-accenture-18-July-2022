module "frontend" { 
  source = "./modules/ec2"
  ec2_count = var.frontend_instance_count
}


module "backend" { 
  source = "./modules/ec2"
  ec2_count = var.backend_instance_count
  region = var.backend_region
}



module "myec2" { 
  source = "./modules/ec2"
}

