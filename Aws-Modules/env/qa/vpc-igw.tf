module "igw" {
  source   = "../../modules/vpc-igw"
  vpc_id   = module.vpc.vpc_id
  vpc_name = var.vpc_name
  env_name = "qa"
}
