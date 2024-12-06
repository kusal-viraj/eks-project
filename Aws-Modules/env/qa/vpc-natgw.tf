module "natgw" {
  source               = "../../modules/vpc-natgw"
  eip_nat_az1          = module.eip.eip_nat_az1
  eip_nat_az2          = module.eip.eip_nat_az2
  #public_subnet_az1_id = module.subnets.public_subnet_az1_id
  #public_subnet_az2_id = module.subnets.public_subnet_az2_id
  #public_subnet_az1_id = module.subnets.public_subnet_az_01
  public_subnet_az1_id = module.vpc-subnets.public_subnet_az_01
  public_subnet_az2_id = module.vpc-subnets.public_subnet_az_02
  env_name             = "qa"
  
}