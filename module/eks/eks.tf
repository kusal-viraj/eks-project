#./module/eks/eks.tf


## Retrieve available availability zones
#data "aws_availability_zones" "available" {}

#locals {
#  cluster_name = var.cluster_name
#  # Specify the AZs you want to use (A and B in this case)
#  desired_azs = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]  # AZ A and B
#}


resource "aws_eks_cluster" "main_eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.main_public_subnet_1.id,aws_subnet.main_public_subnet_2.id,aws_subnet.main_private_app_subnet_1.id,aws_subnet.main_private_app_subnet_2.id]  # Public subnets for frontend
    #subnet_ids = [module.vpc.main_public_subnet_1,module.vpc.main_public_subnet_2,module.vpc.main_private_app_subnet_1,module.vpc.main_private_app_subnet_2]

    endpoint_private_access = true
    endpoint_public_access  = false

    # Cluster security group
    security_group_ids = [aws_security_group.eks_cluster_sg.id]

  }
}

# Frontend Node Group - Managed Node Group
resource "aws_eks_node_group" "frontend_node_group" {
  cluster_name    = aws_eks_cluster.main_eks_cluster.name
  node_group_name = "frontend_node_group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.main_public_subnet_1.id, aws_subnet.main_public_subnet_2.id]

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 4
  }

  instance_types = ["t3.medium"]

  tags = {
    Name = "frontend_node_group"
    Env  = var.env
    "kubernetes.io/cluster/${aws_eks_cluster.main_eks_cluster.name}" = "owned"
  }

  labels = {
    Name = "${var.cluster_name}_frontend_node"
  }


  capacity_type = "ON_DEMAND" # Can also be "SPOT" for spot instances

  # Optional: Disk size for nodes (in GiB)
  disk_size = 20

  update_config {
    max_unavailable = 1
  }

  # Optional: Remote access configuration (for SSH access to nodes)
  remote_access {
    ec2_ssh_key              = var.node_ssh_key_name
    source_security_group_ids = [aws_security_group.eks_frontend_node_group_sg.id]
  }
}

# Backend Node Group - Managed Node Group
resource "aws_eks_node_group" "backend_node_group" {
  cluster_name    = aws_eks_cluster.main_eks_cluster.name
  node_group_name = "backend-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.main_private_app_subnet_1.id, aws_subnet.main_private_app_subnet_2.id]

  scaling_config {
    desired_size = 4
    min_size     = 2
    max_size     = 6
  }

  instance_types = ["t3.large"]

  tags = {
    Name = "backend-node-group"
    Env  = var.env
    "kubernetes.io/cluster/${aws_eks_cluster.main_eks_cluster.name}" = "owned"
  }

  labels = {
    Name = "${var.cluster_name}_backend_node"
  }

  capacity_type = "ON_DEMAND" # Can also be "SPOT" for spot instances

  # Optional: Disk size for nodes (in GiB)
  disk_size = 20

  update_config {
    max_unavailable = 1
  }

  # Optional: Remote access configuration (for SSH access to nodes)
  remote_access {
    ec2_ssh_key              = var.node_ssh_key_name
    source_security_group_ids = [aws_security_group.eks_backend_node_group_sg.id]
  }
}


# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Role for EKS Node Groups
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for the EKS cluster"
  vpc_id      = aws_vpc.main_vpc.id
  #vpc_id      = module.vpc.main_vpc

  ingress {
    description = "Allow worker nodes to communicate with EKS API server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]  # Replace with the correct CIDR block
    #cidr_blocks = [module.vpc.vpc_cidr_block]

  }

  ingress {
    description = "Allow worker nodes to communicate with the kubelet"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    #cidr_blocks = [module.vpc.vpc_cidr_block]

  }

  ingress {
    protocol   = "-1"
   # rule_no    = 103
    #action     = "allow"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "eks_frontend_node_group_sg" {
  name        = "eks-frontend_node-sg"
  description = "Security group for the EKS nodes"
  vpc_id      = aws_vpc.main_vpc.id
  #vpc_id      = module.vpc.main_vpc

  ingress {
    description = "Allow EKS API server to communicate with nodes"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]  # Replace with the correct CIDR block
    #cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    description = "Allow EKS control plane to communicate with nodes"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    #cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    description = "Allow intra-node communication"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Allow intra-node communication"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
    cidr_blocks =[aws_subnet.main_bastion_subnet.cidr_block]
    #cidr_blocks = [module.vpc.bastion_subnet_cidr]
  }

  ingress {
    protocol   = "-1"
    # rule_no    = 103
    #action     = "allow"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "eks_backend_node_group_sg" {
  name        = "eks-backend_node-sg"
  description = "Security group for the EKS nodes"
  vpc_id      = aws_vpc.main_vpc.id


  ingress {
    description = "Allow EKS API server to communicate with nodes"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]  # Replace with the correct CIDR block
    #cidr_blocks = [module.vpc.vpc_cidr_block]

  }

  ingress {
    description = "Allow EKS control plane to communicate with nodes"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    #cidr_blocks = [module.vpc.vpc_cidr_block]

  }

  ingress {
    description = "Allow intra-node communication"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Allow intra-node communication"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
    cidr_blocks =[aws_subnet.main_bastion_subnet.cidr_block]
    #cidr_blocks = [module.vpc.bastion_subnet_cidr]
  }

  ingress {
    protocol   = "-1"
    # rule_no    = 103
    #action     = "allow"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}







