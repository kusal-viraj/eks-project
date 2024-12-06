provider "aws"{
    region      = var.region
    }

module "vpc" {
  source = "../../modules/vpc"
  
  region            =   var.region
  vpc_cidr          =   var.vpc_cidr
  vpc_name          =   var.vpc_name


 
}





