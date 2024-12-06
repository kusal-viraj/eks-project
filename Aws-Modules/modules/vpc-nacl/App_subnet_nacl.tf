
resource "aws_network_acl" "main_private_app_nacl" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = var.public-subnet-bastion-az_01_cidr
    #security_groups = [aws_security_group.bastion_sg.id]
    from_port  = 22
    to_port    = 22
  }

#  ingress {
#    protocol   = "tcp"
#    rule_no    = 102
#    action     = "allow"
#    cidr_block = var.vpc_cidr_block
#    from_port  = 0
#    to_port    = 0
#  }


  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "udp"
    rule_no    = 109
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 1024
    to_port    = 65535
  }


  ingress {
    protocol   = "udp"
    rule_no    = 110
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 53
    to_port    = 53
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 111
    action     = "allow"
    cidr_block = var.vpc_cidr_block
    from_port  = 53
    to_port    = 53
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 112
    action     = "allow"
    #cidr_block = var.vpc_cidr_block
    cidr_block = "0.0.0.0/0"
    from_port  = 10250
    to_port    = 10250
  }

  ingress {
    #description = "Allow EKS API server to communicate with nodes"
    rule_no    = 107
    action     = "allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = var.vpc_cidr_block # Only allow traffic from within the VPC
  }


  egress {
    protocol   = "-1"
    rule_no    = 201
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }


  tags = {
    Name   = "${var.env_name}_APP_Net_acl"
    Env    = var.env_name
#    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}


resource "aws_network_acl_association" "private_app_nacl_association_1" {
  subnet_id      = var.app_subnet_az_01_id
  network_acl_id = aws_network_acl.main_private_app_nacl.id
}

resource "aws_network_acl_association" "private_app_nacl_association_2" {
  subnet_id      = var.app_subnet_az_02_id
  network_acl_id = aws_network_acl.main_private_app_nacl.id
}
