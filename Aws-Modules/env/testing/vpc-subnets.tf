


module "vpc-subnets" {
  source = "../../modules/vpc-subnets"

  vpc_id                           = module.vpc.vpc_id
  public_bastion_subnet_az_01_cidr = var.public_bastion_subnet_az_01_cidr
  web_public_subnet_az1_cidr       = var.web_public_subnet_az1_cidr
  web_public_subnet_az2_cidr       = var.web_public_subnet_az2_cidr
  private_app_subnet_az1_cidr      = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr      = var.private_app_subnet_az2_cidr
  private_rds_subnet_az1_cidr      = var.private_rds_subnet_az1_cidr
  private_rds_subnet_az2_cidr      = var.private_rds_subnet_az2_cidr
  cluster_name                     = var.cluster_name

  env_name                         = var.env_name


}
