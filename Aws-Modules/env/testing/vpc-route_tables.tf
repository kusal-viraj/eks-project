module "route_tables" {
  source               = "../../modules/vpc-route_tables"
  vpc_id               = module.vpc.vpc_id
  vpc_cidr_block       = var.vpc_cidr
  igw_id               = module.igw.igw_id
  bastion_subnet_id    = module.vpc-subnets.public-subnet-bastion-az_01_id
  public_subnet_az1_id = module.vpc-subnets.public_subnet_az_01_id
  public_subnet_az2_id = module.vpc-subnets.public_subnet_az_02_id
  app_subnet_az1_id    = module.vpc-subnets.backend_private_subnet_az_01_id
  app_subnet_az2_id    = module.vpc-subnets.backend_private_subnet_az_02_id
  rds_subnet_az1_id    = module.vpc-subnets.rds_private_subnet_az_01_id
  rds_subnet_az2_id    = module.vpc-subnets.rds_private_subnet_az_02_id
  nat_gw_az1_id        = module.natgw.nat_gw_az1_id
  nat_gw_az2_id        = module.natgw.nat_gw_az2_id
  env_name             = var.vpc_name
}
