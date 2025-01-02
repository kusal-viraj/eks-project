
## source = "../Aws-Modules/modules/vpc-security_groups/bastion_sg.tf"
## Bastion Security Group

#======================================================================

# Define the security group without inline rules
resource "aws_security_group" "bastion_sg" {
  name   = "${var.env_name}_bastion_sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env_name}_bastion_sg"
    Env  = var.env_name
  }
}


# Ingress rule: Allow SSH from VPN IP
resource "aws_security_group_rule" "bastion_ingress_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion_sg.id
  cidr_blocks              = [var.vpn_ip]
  description              = "Allow VPN connection for SSH"
}

# Egress rule: Allow all outbound traffic
resource "aws_security_group_rule" "bastion_egress_all" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.bastion_sg.id
  cidr_blocks              = ["0.0.0.0/0"]
  ipv6_cidr_blocks         = ["::/0"]
}
