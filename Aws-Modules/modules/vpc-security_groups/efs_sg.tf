
## source = "../Aws-Modules/modules/vpc-security_groups/efs_sg.tf"
## EFS drive Security Group

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


