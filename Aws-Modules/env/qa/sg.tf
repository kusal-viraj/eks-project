module "security_group" {
  source   = "../../modules/vpc-security_groups"
  vpc_id   = module.vpc.vpc_id  # Replace with your VPC ID
  sg_name  = "qa-sg"
}
