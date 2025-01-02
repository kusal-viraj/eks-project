module "frontend_node_groups" {
  source        = "../../modules/node_groups/frontend_node_groups"

  cluster_name = var.cluster_name
  env_name = var.env_name
  node_role_arn = module.iam.node_role_arn
  public_subnet_az_01_id = module.vpc-subnets.public_subnet_az_01_id
  public_subnet_az_02_id = module.vpc-subnets.public_subnet_az_02_id

  frontend_launch_template_id = module.launch_templates.frontend_launch_template_id
}
