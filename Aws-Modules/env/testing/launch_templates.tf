module "launch_templates" {
  source = "../../modules/launch_templates"

  node_ssh_key_name = var.node_ssh_key_name
  env_name = var.env_name
  cluster_name = var.cluster_name
  frontend_node_sg_id = module.security_group.frontend_node_sg_id
  backend_node_sg_id = module.security_group.backend_node_sg_id
  backend_node_rds_sg_id = module.security_group.backend_node_rds_sg_id
#  node_group_ami = var.node_group_ami  # Use the appropriate AMI
#  cluster_endpoint = module.eks.cluster_endpoint
#  cluster_ca        = module.eks.cluster_ca

}
