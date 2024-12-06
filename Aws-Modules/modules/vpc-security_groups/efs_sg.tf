
#=======================================================================

resource "aws_security_group" "main_efs_sg" {
  name = "${var.env_name}-efs-sg"
  description = "Security group for EFS mount targets"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}-efs-sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

#===========ingress rules==============================================

resource "aws_security_group_rule" "main_efs_nfs_ingress" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.main_efs_sg.id
  source_security_group_id = aws_security_group.eks_backend_node_group_sg.id
  description       = "Allow NFS traffic from backend node group"
}


#===============Egress rules===========================================

resource "aws_security_group_rule" "main_efs_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.main_efs_sg.id
  cidr_blocks       = [var.vpc_cidr_block]  # Update with the correct CIDR block if necessary
  description       = "Allow all outbound traffic"
}


#======================================================================


#resource "aws_security_group" "main_efs_sg" {
##  name        = "${var.env_name}-efs-sg"
#  description = "Security group for EFS mount targets"
#  vpc_id      = var.vpc_id
#
#  # Allow NFS traffic (port 2049) from within the VPC or specific instances
#  ingress {
#    from_port   = 2049
#    to_port     = 2049
#    protocol    = "tcp"
#    #cidr_blocks = ["10.0.0.0/16"]  # Replace with your VPC CIDR or allow only specific sources
#    security_groups = [aws_security_group.eks_backend_node_group_sg.id]
#  }
#
#  # Allow all egress traffic
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = [var.vpc_cidr_block] # Replace with the correct CIDR block # the cidr block shoulbe insert as a list for sg
#  }
#
#  tags = {
#    Name = "${var.env_name}-efs-sg"
#    Env  = var.env_name
#  }
#}
