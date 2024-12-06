

#======================================================================

resource "aws_security_group" "main_alb_sg" {
  name        = "${var.env_name}-alb-sg"
  description = "Security group for the Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}-alb-sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


#===========ingress rules==============================================

resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  security_group_id = aws_security_group.main_alb_sg.id

  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere

  description       = "Allow HTTP traffic on port 80"
}

resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  security_group_id = aws_security_group.main_alb_sg.id

  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]  # Allow HTTPS traffic from anywhere

  description       = "Allow HTTPS traffic on port 443"
}


#===============Egress rules===========================================

resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  security_group_id = aws_security_group.main_alb_sg.id

  from_port         = 0
  to_port           = 0
  protocol          = "-1"  # Allow all outbound traffic
  cidr_blocks       = ["0.0.0.0/0"]  # Modify this to restrict egress as needed

  description       = "Allow all outbound traffic"
}


#======================================================================







#resource "aws_security_group" "main_alb_sg" {
#  name        = "${var.env_name}-efs-sg"
#  description = "Security group for EFS mount targets"
#  vpc_id      = var.vpc_id
#
#  # Allow NFS traffic (port 2049) from within the VPC or specific instances
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]  # Replace with your VPC CIDR or allow only specific sources
#    #security_groups = aws_security_group.eks_backend_node_group_sg.id
#  }
#
#  ingress {
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"] # Replace with your VPC CIDR or allow only specific sources
#    #security_groups = aws_security_group.eks_backend_node_group_sg.id
#  }
#
#  # Allow all egress traffic
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    #cidr_blocks = ["10.50.0.0/16"]
#    security_groups = [aws_security_group.eks_frontend_node_group_sg.id]
#  }
#
#  tags = {
#    Name = "${var.env_name}-efs-sg"
#    Env  = var.env_name
#  }
#}
