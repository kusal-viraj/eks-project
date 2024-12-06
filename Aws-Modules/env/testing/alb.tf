

module "alb" {
  source = "../../modules/alb"

  env_name = var.env_name
  cluster_name = var.cluster_name
  vpc_id = module.vpc.vpc_id
  alb_sg_id = module.security_group.alb_sg_id
  public_subnet_az_01_id = module.vpc-subnets.public_subnet_az_01_id
  public_subnet_az_02_id = module.vpc-subnets.public_subnet_az_02_id
  acm_certificate_arn = var.acm_certificate_arn

}
