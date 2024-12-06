resource "aws_network_acl" "main_bastion_nacl" {

  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpn_ip
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }



  tags = {
    Name                                          = "${var.env_name}_SSH_Net_acl"
    Env                                           = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_network_acl_association" "bastion_nacl_association" {
  subnet_id      = var.bastion_subnet_id
  network_acl_id = aws_network_acl.main_bastion_nacl.id
}
