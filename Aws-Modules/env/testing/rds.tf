module "rds" {
  source = "../../modules/rds"


  env_name = var.env_name
  vpc_id                 = module.vpc.vpc_id
  rds_sg_id = module.security_group.rds_sg_id
  private_rds_subnet_ids = [module.vpc-subnets.rds_private_subnet_az_01_id,module.vpc-subnets.rds_private_subnet_az_02_id]

  allocated_storage       = var.db_allocated_storage
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  username                = var.db_username
  password                = var.db_password
  rds_db_port             = var.db_rds_db_port
  storage_type            = var.db_storage_type
  multi_az                = var.db_multi_az
  backup_retention        = var.db_backup_retention

}
