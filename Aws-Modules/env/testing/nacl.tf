module "nacl" {
  source         = "../../modules/vpc-nacl"
  vpc_id         = module.vpc.vpc_id # Replace with your VPC ID
  vpc_cidr_block = var.vpc_cidr
  env_name       = var.env_name

  vpn_ip = var.vpn_ip

  bastion_subnet_id = module.vpc-subnets.public-subnet-bastion-az_01_id
  public-subnet-bastion-az_01_cidr = module.vpc-subnets.public-subnet-bastion-az_01_cidr

  app_subnet_az_01_id = module.vpc-subnets.backend_private_subnet_az_01_id
  app_subnet_az_02_id = module.vpc-subnets.backend_private_subnet_az_02_id

  public_subnet_az_01_id = module.vpc-subnets.public_subnet_az_01_id
  public_subnet_az_02_id = module.vpc-subnets.public_subnet_az_02_id

  rds_subnet_az_01_id = module.vpc-subnets.rds_private_subnet_az_01_id
  rds_subnet_az_02_id = module.vpc-subnets.rds_private_subnet_az_02_id

}
