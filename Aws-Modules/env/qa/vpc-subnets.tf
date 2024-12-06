

/*

 module "qa-subnets" {
  source = "../../modules/vpc-subnets"
  
 
  vpc_name          =   var.vpc_name
  public-bastian-subnet-cidr-az_01 = var.public-astian-subnet-cidr-az_01
}
*/
module "vpc-subnets" {
  source = "../../modules/vpc-subnets"

  vpc_id = module.vpc.vpc_id
  public_bastian_subnet_cidr_az_01 = var.public_bastian_subnet_cidr_az_01
  web_public_subnet_cidr_01    = var.web_public_subnet_cidr_01
  web_public_subnet_cidr_02    = var.web_public_subnet_cidr_02
  private_subnet_cidr_01       = var.private_subnet_cidr_01
  private_subnet_cidr_02       = var.private_subnet_cidr_02
  env_name                     = var.env_name
   
 
}
