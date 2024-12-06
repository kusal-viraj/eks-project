module "ec2_keys" {
  source   = "../../modules/ecs-keys"
  key_name = "qa-key"
}

# Save public and private keys to local files
resource "local_file" "private_key" {
  content  = module.ec2_keys.private_key_pem
  filename = "${path.module}/qa-private-key.pem"
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content  = module.ec2_keys.public_key
  filename = "${path.module}/qa-public-key.pub"
}
