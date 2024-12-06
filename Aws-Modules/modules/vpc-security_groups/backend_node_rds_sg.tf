
#======================================================================

resource "aws_security_group" "main_backend_node_rds_sg" {
  name        = "${var.env_name}_backend_node_rds_sg"
  description = "Security group for the EKS nodes to connect to RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}_backend_node_rds_sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"

  }
}


#===========ingress rules==============================================



#===============Egress rules===========================================

resource "aws_security_group_rule" "egress_rds_to_subnets" {
  type              = "egress"
  security_group_id = aws_security_group.main_backend_node_rds_sg.id

  from_port         = var.rds_db_port
  to_port           = var.rds_db_port
  protocol          = "tcp"
  cidr_blocks       = [var.rds_subnet_1_cidr_block, var.rds_subnet_2_cidr_block]

  description       = "Allow outbound RDS traffic to specific RDS subnets"
}


#======================================================================





#resource "aws_security_group" "main_backend_node_rds_sg" {
#
#  name        = "${var.env_name}_backend_node_rds_sg"
#  description = "Security group for the EKS nodes to connect to rds"
#  vpc_id = var.vpc_id
#
#  tags = {
#    Name = "${var.env_name}_backend_node_rds_sg"
#    Env  = var.env_name
#  }
#
#  egress {
#    from_port   = var.rds_db_port
#    to_port     = var.rds_db_port
#    protocol    = "tcp"
#    cidr_blocks = [var.rds_subnet_1_cidr_block, var.rds_subnet_2_cidr_block]
#  }
#}
