resource "aws_network_acl" "main_public_nacl" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = var.public-subnet-bastion-az_01_cidr
    from_port  = 22
    to_port    = 22
  }

  ingress {
    #description = "Allow EKS control plane to communicate with nodes"
    rule_no    = 104
    action     = "allow"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_block = var.vpc_cidr_block # Only allow traffic from within the VPC
#    cidr_block  = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 105
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "udp"
    rule_no    = 106
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }


  ingress {
    protocol   = "udp"
    rule_no    = 107
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 53
    to_port    = 53
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 108
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 53
    to_port    = 53
  }

#  ingress {
#    protocol   = "tcp"
#    rule_no    = 109
#    action     = "allow"
#    cidr_block = var.vpc_cidr_block
#    from_port  = 10250
#    to_port    = 10250
#  }


  egress {
    protocol   = "-1"
    rule_no    = 201
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }


  tags = {
    Name                                           = "${var.env_name}_WEB_Net_acl"
    Env                                            = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_network_acl_association" "public_nacl_association_1" {
  subnet_id      = var.public_subnet_az_01_id
  network_acl_id = aws_network_acl.main_public_nacl.id
}

resource "aws_network_acl_association" "public_nacl_association_2" {
  subnet_id      = var.public_subnet_az_02_id
  network_acl_id = aws_network_acl.main_public_nacl.id
}
