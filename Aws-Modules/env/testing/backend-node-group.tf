

module "backend_node_groups" {
  source        = "../../modules/node_groups/backend_node_groups"

  cluster_name = var.cluster_name
  env_name = var.env_name
  node_role_arn = module.iam.node_role_arn
  backend_private_subnet_az_01_id = module.vpc-subnets.backend_private_subnet_az_01_id
  backend_private_subnet_az_02_id = module.vpc-subnets.backend_private_subnet_az_02_id

  backend_launch_template_id = module.launch_templates.backend_launch_template_id


}
