
resource "aws_network_acl" "main_private_rds_nacl" {
  vpc_id = var.vpc_id


  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "-1"
    rule_no    = 202
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name                                          = "${var.env_name}_private_rds_nacl"
    Env                                           = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_network_acl_association" "private_rds_nacl_association_1" {
  subnet_id      = var.rds_subnet_az_01_id
  network_acl_id = aws_network_acl.main_private_rds_nacl.id
}

resource "aws_network_acl_association" "private_rds_nacl_association_2" {
  subnet_id      = var.rds_subnet_az_02_id
  network_acl_id = aws_network_acl.main_private_rds_nacl.id
}
