module "ebs_attached" {
  source      = "../../modules/ebs-attached"
  volume_id   = module.ebs.ebs_volume_id
  instance_id = module.ec2.instance_id
}
