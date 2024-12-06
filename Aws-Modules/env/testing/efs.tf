module "efs" {
  source = "../../modules/efs"

  env_name = var.env_name
  efs_subnet_ids = [module.vpc-subnets.public_subnet_az_01_id,module.vpc-subnets.public_subnet_az_02_id]
  efs_sg_id = module.security_group.efs_sg_id



}
