
## source = "../Aws-Modules/modules/vpc-security_groups/eks_sg.tf"
## EKS Cluster(control plane) Security Group


resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.env_name}-eks-cluster-sg"
  description = "Security group for the EKS cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}-eks-cluster-sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


#===========ingress rules=====================================

# Allow worker nodes to communicate with EKS API server on port 443
resource "aws_security_group_rule" "eks_cluster_api_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = [var.vpc_cidr_block]  # Update with the correct CIDR block
  description       = "Allow worker nodes to communicate with EKS API server"
}

# Allow worker nodes to communicate with the kubelet on port 10250
resource "aws_security_group_rule" "eks_cluster_kubelet_ingress" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = [var.vpc_cidr_block]  # Update with the correct CIDR block
  description       = "Allow worker nodes to communicate with the kubelet"
}


#===============Egress rules===========================================

# Allow all egress traffic
resource "aws_security_group_rule" "eks_cluster_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
}


#=======================================================================


