
resource "aws_security_group" "main_rds_sg" {
  name = "${var.env_name}_rds_sg"
  description = "Security group for the EKS nodes to connect to RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}_rds_sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


resource "aws_security_group_rule" "main_rds_ingress" {
  type              = "ingress"
  from_port         = var.rds_db_port
  to_port           = var.rds_db_port
  protocol          = "tcp"
  security_group_id = aws_security_group.main_rds_sg.id
  cidr_blocks       = [var.app_subnet_1_cidr_block, var.app_subnet_2_cidr_block]
  description       = "Allow traffic to RDS from application subnets"
}



#resource "aws_security_group" "main_rds_sg" {
#
##  name        = "${var.env_name}_backend_node_rds_sg"
#  description = "Security group for the EKS nodes to connect to rds"
#  vpc_id = var.vpc_id
#
#  tags = {
#    Name = "${var.env_name}_backend_node_rds_sg"
#    Env  = var.env_name
#  }
#
#  ingress {
#    from_port   = var.rds_db_port
#    to_port     = var.rds_db_port
#    protocol    = "tcp"
#    cidr_blocks = [var.app_subnet_1_cidr_block, var.app_subnet_2_cidr_block]
#  }
#}
