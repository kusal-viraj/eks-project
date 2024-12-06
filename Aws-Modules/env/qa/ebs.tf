module "ebs" {
  source            = "../../modules/ebs"
  availability_zone = "ap-south-1a"
  volume_size       = 10
  volume_name       = "qa-ebs"
}
