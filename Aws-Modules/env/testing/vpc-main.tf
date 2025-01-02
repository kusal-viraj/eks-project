

module "vpc" {
  source = "../../modules/vpc"

  region      = var.region
  vpc_cidr    = var.vpc_cidr
  vpc_name    = var.vpc_name
  vpc_tenancy = var.vpc_tenancy
  env_name    = var.env_name####

}





