module "ec2" {
  source        = "../../modules/ec2"

  env_name              = var.env_name
  bastion_ami_id           = var.bastion_ami_id
  bastion_instance_type = var.bastion_instance_type
  Bastion_key_name      = var.Bastion_key_name
  bastion_subnet_id     = module.vpc-subnets.public-subnet-bastion-az_01_id
  #  instance_name               = "qa-ec2-instance"
  bastion_sg_id      = module.security_group.ssh_sg_id

}

