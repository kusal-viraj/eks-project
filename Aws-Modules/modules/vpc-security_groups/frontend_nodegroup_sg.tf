


resource "aws_security_group" "eks_frontend_node_group_sg" {
  name        = "${var.env_name}-eks-frontend-nodegroup-sg"
  description = "Security group for the Frontend EKS nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}_eks_frontend_node-sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


#===========ingress rules=====================================

# SSH access from the bastion security group
resource "aws_security_group_rule" "frontend_nodegroup_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
  description       = "Allow SSH communication from Bastion SG"
}

# EKS API server to communicate with nodes on port 443
resource "aws_security_group_rule" "frontend_nodegroup_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  source_security_group_id = aws_security_group.main_alb_sg.id
#  cidr_blocks       = ["0.0.0.0/0"]  # Replace with specific CIDR if required
  description       = "Allow EKS API server to communicate with nodes on HTTPS"
}

# EKS API server to communicate with nodes on port 80
resource "aws_security_group_rule" "frontend_nodegroup_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  source_security_group_id = aws_security_group.main_alb_sg.id
#  cidr_blocks       = ["0.0.0.0/0"]  # Replace with specific CIDR if required
  description       = "Allow EKS API server to communicate with nodes on HTTP"
}

# CoreDNS communication within the cluster (UDP port 53)
resource "aws_security_group_rule" "frontend_nodegroup_dns_udp" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow CoreDNS communication within the cluster (UDP)"
}

# CoreDNS communication within the cluster (TCP port 53)
resource "aws_security_group_rule" "frontend_nodegroup_dns_tcp" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow CoreDNS communication within the cluster (TCP)"
}

# NodePort communication within cluster (TCP ports 30000-32762)
resource "aws_security_group_rule" "frontend_nodegroup_nodeport" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32762
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow NodePort communication within the cluster"
}

resource "aws_security_group_rule" "frontend_allow_backend" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_frontend_node_group_sg.id
  source_security_group_id = aws_security_group.eks_backend_node_group_sg.id
  #cidr_blocks       = ["0.0.0.0/0"]
  description              = "Allow backend node group to communicate with frontend nodes"
}

resource "aws_security_group_rule" "frontend_allow_control_plane" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_frontend_node_group_sg.id
  source_security_group_id = var.control_plane_security_group_id
#  cidr_blocks       = ["0.0.0.0/0"]
  description              = "Allow backend node group to communicate with frontend nodes"
}



#===============Egress rules===========================================

resource "aws_security_group_rule" "frontend_nodegroup_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
}


#=======================================================================





#resource "aws_security_group" "eks_frontend_node_group_sg" {
#  name        = "${var.env_name}-eks-frontend-nodegroup-sg"
#  description = "Security group for the Front end EKS nodes"
#  vpc_id      = var.vpc_id
#
#
#  ingress {
#
#    description     = "Allow ssh communication"
#    protocol        = "tcp"
#    #cidr_block     = "10.50.10.0/24"
#    security_groups = [aws_security_group.bastion_sg.id]
#    from_port       = 22
#    to_port         = 22
#  }
#
#  ingress {
#
#    description = "Allow EKS API server to communicate with nodes"
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]  # Replace with the correct CIDR block
#    #cidr_blocks = [module.vpc.vpc_cidr_block]
#  }
#
#  ingress {
#
#    description = "Allow EKS API server to communicate with nodes"
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"] # Replace with the correct CIDR block
#    #cidr_blocks = [module.vpc.vpc_cidr_block]
#  }
#
##  ingress {
##    description = "Allow EKS control plane to communicate with nodes"
##    from_port   = 10250
##    to_port     = 10250
##    protocol    = "tcp"
##    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
##    #cidr_blocks = [module.vpc.vpc_cidr_block]
##  }
#
#  ingress {
#    description = "Allow coredns communications within cluster"
#    protocol   = "udp"
#    from_port  = 53
#    to_port    = 53
#    cidr_blocks = [var.vpc_cidr_block] # Replace with the correct CIDR block # the cidr block shoulbe insert as a list for sg
#  }
#
#  ingress {
#    description = "Allow coredns communications within cluster"
#    protocol   = "tcp"
#    from_port  = 53
#    to_port    = 53
#    cidr_blocks = [var.vpc_cidr_block] # Replace with the correct CIDR block # the cidr block shoulbe insert as a list for sg
#  }
#
#  ingress {
#    description = "Allow coredns communications within cluster"
#    protocol   = "tcp"
#    from_port  = 30000
#    to_port    = 32762
#    cidr_blocks = [var.vpc_cidr_block] # Replace with the correct CIDR block # the cidr block shoulbe insert as a list for sg
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = {
#    Name                                            = "${var.env_name}_eks_frontend_node-sg"
#    Env  = var.env_name
#    #    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
#  }
#}