module "ec2" {
  source        = "../../modules/ec2"
  ami_id        = "ami-0d1622042e957c247"
  instance_type = "t2.micro"
  key_name      = module.ec2_keys.keyname
  subnet_id     = module.vpc-subnets.public_subnet_az_01 # Replace with actual Subnet ID
  instance_name = "qa-ec2-instance"
  security_group_ids = [module.security_group.sg_id]
  #security_group_ids = [module.vpc-security_groups.sg_id]
  #security_group_ids = module.vpc-security_groups.sg_id
}
