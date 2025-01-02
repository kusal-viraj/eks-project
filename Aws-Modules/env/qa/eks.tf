module "eks" {
  source        = "../../modules/eks"

  env_name              = var.env_name
  cluster_name          = var.cluster_name
  eks_cluster_role_arn  = module.iam.cluster_role_arn
  eks_node_role_arn     = module.iam.node_role_arn
  public_subnet_az_01   = module.vpc-subnets.public_subnet_az_01_id
  public_subnet_az_02   = module.vpc-subnets.public_subnet_az_02_id

  app_subnet_az_01      = module.vpc-subnets.backend_private_subnet_az_01_id
  app_subnet_az_02      = module.vpc-subnets.backend_private_subnet_az_02_id

  eks_cluster_sg_id     = module.security_group.eks_cluster_sg_id

  account_id            = var.account_id
  additional_users      = var.additional_users
}
