# Root main.tf

module "vpc" {
  source = "./module/vpc" # Adjust this path if your VPC module is in a different directory

  vpc_name     = var.vpc_name
  vpc_tenancy  = var.vpc_tenancy
  env          = var.env
  cluster_name = var.cluster_name

  vpc_cidr_block = var.vpc_cidr_block

  bastion_subnet_cidr = var.bastion_subnet_cidr

  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_app_subnet_1_cidr = var.private_app_subnet_1_cidr
  private_app_subnet_2_cidr = var.private_app_subnet_2_cidr
  private_rds_subnet_1_cidr = var.private_rds_subnet_1_cidr
  private_rds_subnet_2_cidr = var.private_rds_subnet_2_cidr

  bastion_ami_id        = var.bastion_ami_id
  bastion_instance_name = var.bastion_instance_name
  Bastion_key_name      = var.Bastion_key_name
  bastion_instance_type = var.bastion_instance_type
  vpn_ip                = var.vpn_ip

  # Any other variables.tf specific to the EKS module
  node_ssh_key_name = var.node_ssh_key_name

}


#module "eks" {
#  source = "./module/eks"
#
#  # Pass the required variables.tf to the eks module
#
#
#  cluster_name       = var.cluster_name
#  vpc_name     = var.vpc_name
#  vpc_tenancy  = var.vpc_tenancy
#  env          = var.env
#
#
#
#  # Any other variables.tf specific to the EKS module
#  node_ssh_key_name = var.node_ssh_key_name
#
#}

module "rds" {
  source = "./module/rds"

  vpc_id                 = module.vpc.vpc_id                 # Obtained from VPC module output
  private_rds_subnet_ids = module.vpc.private_rds_subnet_ids # Obtained from VPC module output
  backend_subnet_cidrs   = module.vpc.private_app_subnet
  env                    = var.env
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = var.db_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  port                   = var.db_port
  multi_az               = var.db_multi_az
  backup_retention       = var.db_backup_retention
  storage_type           = var.db_storage_type
  skip_final_snapshot    = var.final_snapshot
  cluster_name           = var.cluster_name
  snapshot_id            = var.snapshot
}


module "efs" {
  source = "./module/efs"

  efs_subnet_ids          = [module.vpc.private_app_subnet]
  backend_nodegroup_sg_id = module.vpc.backend_nodegroup_sg_id
  env                     = var.env

}
