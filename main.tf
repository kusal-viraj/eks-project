# Root main.tf

module "vpc" {
  source = "./module/vpc" # Adjust this path if your VPC module is in a different directory

  vpc_cidr_block = var.vpc_cidr_block

  bastion_subnet_name = var.bastion_subnet_name
  bastion_subnet_cidr = var.bastion_subnet_cidr

  public_subnet_1_name = var.public_subnet_1_name
  public_subnet_1_cidr = var.public_subnet_1_cidr

  public_subnet_2_name = var.public_subnet_2_name
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_app_subnet_1_name = var.private_app_subnet_1_name
  private_app_subnet_1_cidr = var.private_app_subnet_1_cidr

  private_app_subnet_2_name = var.private_app_subnet_2_name
  private_app_subnet_2_cidr = var.private_app_subnet_2_cidr

  private_rds_subnet_1_name = var.private_rds_subnet_1_name
  private_rds_subnet_1_cidr = var.private_rds_subnet_1_cidr

  private_rds_subnet_2_name = var.private_rds_subnet_2_name
  private_rds_subnet_2_cidr = var.private_rds_subnet_2_cidr

  bastion_nacl     = var.bastion_nacl
  public_nacl      = var.public_nacl
  private_app_nacl = var.private_app_nacl
  private_rds_nacl = var.private_rds_nacl


  public_rt    = var.public_rt
  private_rt_1 = var.private_rt_1
  private_rt_2 = var.private_rt_2
  nat_gw_1     = var.nat_gw_1
  nat_gw_2     = var.nat_gw_2
  eip_1        = var.eip_1
  eip_2        = var.eip_2

  vpc_name     = var.vpc_name
  vpc_tenancy  = var.vpc_tenancy
  env          = var.env
  igw_name     = var.igw_name
  cluster_name = var.cluster_name

  bastion_sg_name       = var.bastion_sg_name
  bastion_ami_id        = var.bastion_ami_id
  bastion_instance_name = var.bastion_instance_name
  Bastion_key_name      = var.Bastion_key_name
  bastion_instance_type = var.bastion_instance_type
  vpn_ip                = var.vpn_ip

  frontend_node_group_ami = var.frontend_node_group_ami
  backend_node_group_ami  = var.backend_node_group_ami
  node_ssh_key_name=var.node_ssh_key_name

}

#module "eks" {
#  source = "./module/eks" # Adjust this path if your VPC module is in a different directory
#
#  vpc_id          = module.vpc.vpc_id
#  public_subnets  = [module.vpc.main_public_subnet_1, module.vpc.main_public_subnet_2]
#  private_subnets = [module.vpc.main_private_app_subnet_1, module.vpc.main_private_app_subnet_2]
#}



