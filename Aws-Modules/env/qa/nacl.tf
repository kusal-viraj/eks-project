module "nacl" {
  source   = "../../modules/vpc-nacl"
  vpc_id   = module.vpc.vpc_id  # Replace with your VPC ID
  nacl_name = "qa-nacl"
}
