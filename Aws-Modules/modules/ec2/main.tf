
resource "aws_instance" "bastion_instance" {

  ami                         = var.bastion_ami_id               # Replace with the AMI ID you want to use
  instance_type               = var.bastion_instance_type        # Replace with your desired instance type (e.g., "t2.micro")
  subnet_id                   = var.bastion_subnet_id            # This refers to the Bastion subnet you defined earlier
  key_name                    = var.Bastion_key_name             # The name of the key pair to use for SSH access
  associate_public_ip_address = true                             # Ensure the instance has a public IP
  vpc_security_group_ids      = [var.bastion_sg_id]                # Reference the security group here

  tags = {
    Name                      = "${var.env_name}-SSH-Instance"  # Replace with the desired instance name
    Env                       = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  user_data = base64encode(file("${path.module}/user.sh"))

  # Ensure the instance is created after the subnet and security groups
  #depends_on = [aws_subnet.main_bastion_subnet, aws_security_group.bastion_sg]
}
