module "route_tables" {
  source              = "../../modules/vpc-route_tables"
  vpc_id              = module.vpc.vpc_id
  igw_id              = module.igw.igw_id
  #public_subnet_az1_id = module.vpc-subnets.public_subnet_az1_id
  #public_subnet_az2_id = module.vpc-subnets.public_subnet_az2_id
  public_subnet_az1_id = module.vpc-subnets.public_subnet_az_01
  public_subnet_az2_id = module.vpc-subnets.public_subnet_az_02
  nat_gw_az1_id       = module.natgw.nat_gw_az1_id
  nat_gw_az2_id       = module.natgw.nat_gw_az2_id
  env_name            = "qa"
}