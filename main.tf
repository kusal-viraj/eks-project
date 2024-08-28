# Root main.tf

module "vpc" {
  source = "./module/vpc" # Adjust this path if your VPC module is in a different directory

  vpc_cidr_block = var.vpc_cidr_block


  bastion_subnet_cidr = var.bastion_subnet_cidr


  public_subnet_1_cidr = var.public_subnet_1_cidr


  public_subnet_2_cidr = var.public_subnet_2_cidr


  private_app_subnet_1_cidr = var.private_app_subnet_1_cidr


  private_app_subnet_2_cidr = var.private_app_subnet_2_cidr


  private_rds_subnet_1_cidr = var.private_rds_subnet_1_cidr


  private_rds_subnet_2_cidr = var.private_rds_subnet_2_cidr


  vpc_name     = var.vpc_name
  vpc_tenancy  = var.vpc_tenancy
  env          = var.env
  cluster_name = var.cluster_name


  bastion_ami_id        = var.bastion_ami_id
  bastion_instance_name = var.bastion_instance_name
  Bastion_key_name      = var.Bastion_key_name
  bastion_instance_type = var.bastion_instance_type
  vpn_ip                = var.vpn_ip

  node_ssh_key_name=var.node_ssh_key_name

}




