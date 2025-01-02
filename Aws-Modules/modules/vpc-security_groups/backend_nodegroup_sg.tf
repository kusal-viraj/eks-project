
## source = "../Aws-Modules/modules/vpc-security_groups/backend_nodegroup_sg.tf"
## Backend nodes Security Group

#======================================================================

resource "aws_security_group" "eks_backend_node_group_sg" {
  name        = "${var.env_name}_eks_backend_node-sg"
  description = "Security group for the EKS backend nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env_name}_eks_backend_node-sg"
    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


#===========ingress rules==============================================

# SSH access from Bastion security group
resource "aws_security_group_rule" "ssh_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_backend_node_group_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
  description              = "Allow SSH from Bastion security group"
}



# Allow control plane access from specific CIDR
resource "aws_security_group_rule" "eks_control_plane_access_for_lb_controller" {
  type              = "ingress"
  from_port         = 9443
  to_port           = 9443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  source_security_group_id = var.control_plane_security_group_id
  #  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow EKS lb controller to communicate with the Kubernetes API server."
}

# EKS metrics server to communicate with nodes on port 443
resource "aws_security_group_rule" "backend_nodegroup_metrics_server_from_front" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  source_security_group_id = aws_security_group.eks_frontend_node_group_sg.id
  #  cidr_blocks       = ["0.0.0.0/0"]  # Replace with specific CIDR if required
  description       = "Allow EKS metrics server to communicate with  front end nodes on HTTPS"
}

# EKS metrics server to communicate with nodes on port 443
resource "aws_security_group_rule" "backend_nodegroup_metrics_server_from_back" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  source_security_group_id = aws_security_group.eks_backend_node_group_sg.id
  #  cidr_blocks       = ["0.0.0.0/0"]  # Replace with specific CIDR if required
  description       = "Allow EKS metrics server to communicate with backend nodes on HTTPS"
}

# Allow kubelet API access from the control plane
resource "aws_security_group_rule" "kubelet_api_access" {
  type              = "ingress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  source_security_group_id = var.control_plane_security_group_id
#  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow kubelet API access from control plane"
}


# Allow core dns access from the vpc
resource "aws_security_group_rule" "core_dns_access_udp" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
#  source_security_group_id = var.control_plane_security_group_id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow coredns access from vpc"
}

# Allow core dns access from the vpc
resource "aws_security_group_rule" "core_dns_access_tcp" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  #  source_security_group_id = var.control_plane_security_group_id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow coredns access from vpc"
}

# Proxy service communication
resource "aws_security_group_rule" "proxy_service_ingress" {
  type              = "ingress"
  from_port         = var.proxy_service_port
  to_port           = var.proxy_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow proxy service communication"
}

# Repeat for each specific service
resource "aws_security_group_rule" "auth_service_ingress" {
  type              = "ingress"
  from_port         = var.auth_service_port
  to_port           = var.auth_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow auth service communication"
}

# VP service communication
resource "aws_security_group_rule" "vp_service_ingress" {
  type              = "ingress"
  from_port         = var.vp_service_port
  to_port           = var.vp_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow VP service communication"
}

# UMM service communication
resource "aws_security_group_rule" "umm_service_ingress" {
  type              = "ingress"
  from_port         = var.umm_service_port
  to_port           = var.umm_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow UMM service communication"
}

# Tenant service communication
resource "aws_security_group_rule" "tenant_service_ingress" {
  type              = "ingress"
  from_port         = var.tenant_service_port
  to_port           = var.tenant_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow Tenant service communication"
}

# Integration service communication
resource "aws_security_group_rule" "integration_service_ingress" {
  type              = "ingress"
  from_port         = var.integration_service_port
  to_port           = var.integration_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow Integration service communication"
}

# Common service communication
resource "aws_security_group_rule" "common_service_ingress" {
  type              = "ingress"
  from_port         = var.common_service_port
  to_port           = var.common_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow Common service communication"
}

# Message service communication
resource "aws_security_group_rule" "message_service_ingress" {
  type              = "ingress"
  from_port         = var.message_service_port
  to_port           = var.message_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow Message service communication"
}

# Payment service communication
resource "aws_security_group_rule" "payment_service_ingress" {
  type              = "ingress"
  from_port         = var.payment_service_port
  to_port           = var.payment_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow Payment service communication"
}

#-----------------erp-connectors-----------------------------------

# bcc service communication
resource "aws_security_group_rule" "bcc_service_ingress" {
  type              = "ingress"
  from_port         = var.bcc_service_port
  to_port           = var.bcc_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow bcc service communication"
}


#qbo service communication
resource "aws_security_group_rule" "qbo_service_ingress" {
  type              = "ingress"
  from_port         = var.qbo_service_port
  to_port           = var.qbo_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow qbo service communication"
}


#-----------------payment-connectors-----------------------------------


#usb service communication
resource "aws_security_group_rule" "usb_service_ingress" {
  type              = "ingress"
  from_port         = var.usb_service_port
  to_port           = var.usb_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow usb service communication"
}

#notifiction service communication
resource "aws_security_group_rule" "notification_service_ingress" {
  type              = "ingress"
  from_port         = var.notification_service_port
  to_port           = var.notification_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow notification service communication"
}

#checkeeper service communication
resource "aws_security_group_rule" "checkeeper_service_ingress" {
  type              = "ingress"
  from_port         = var.checkeeper_service_port
  to_port           = var.checkeeper_service_port
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow checkeeper service communication"
}



# Example for the EFS NFS communication rule
resource "aws_security_group_rule" "nfs_efs_ingress" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allow EKS worker nodes to communicate with EFS via NFS"
}


#===============Egress rules===========================================

resource "aws_security_group_rule" "all_outbound_traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_backend_node_group_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
}


#======================================================================

