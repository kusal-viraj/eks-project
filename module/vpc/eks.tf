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
    endpoint_public_access  = true

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

  launch_template {
    id      = aws_launch_template.frontend_launch_template.id
    version = "$Latest"

  }

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
  #disk_size = 20

  update_config {
    max_unavailable = 1
  }


}


# Backend Node Group - Managed Node Group
resource "aws_eks_node_group" "backend_node_group" {
  cluster_name    = aws_eks_cluster.main_eks_cluster.name
  node_group_name = "backend-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.main_private_app_subnet_1.id, aws_subnet.main_private_app_subnet_2.id]

  launch_template {
    id      = aws_launch_template.backend_launch_template.id
    version = "$Latest"

  }

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
  #disk_size = 20

  update_config {
    max_unavailable = 1
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

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]
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

# Additional Inline Policy for EFS Access
resource "aws_iam_policy" "efs_access_policy" {
  name        = "EKSNodeEFSAccessPolicy"
  description = "Policy to allow EKS nodes to access EFS"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeMountTargets",
        "elasticfilesystem:CreateAccessPoint",
        "elasticfilesystem:CreateFileSystem",
        "elasticfilesystem:DeleteAccessPoint",
        "elasticfilesystem:DeleteFileSystem",
        "elasticfilesystem:ListTagsForResource",
        "elasticfilesystem:TagResource",
        "elasticfilesystem:UntagResource",
        "elasticfilesystem:UpdateFileSystem",
      ]
      Resource = "*"
    }]
  })
}

# Attach the EFS Access Policy to the Node Role
resource "aws_iam_role_policy_attachment" "attach_efs_policy" {
  policy_arn = aws_iam_policy.efs_access_policy.arn
  role       = aws_iam_role.eks_node_role.name
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

    description = "Allow ssh communication"
    protocol   = "tcp"
    #cidr_block = "10.50.10.0/24"
    security_groups = [aws_security_group.bastion_sg.id]
    from_port  = 22
    to_port    = 22
  }

  ingress {

    description = "Allow EKS API server to communicate with nodes"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with the correct CIDR block
    #cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {

    description = "Allow EKS API server to communicate with nodes"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with the correct CIDR block
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
    description = "Allow coredns communications within cluster"
    protocol   = "udp"
    from_port  = 53
    to_port    = 53
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  ingress {
    description = "Allow coredns communications within cluster"
    protocol   = "tcp"
    from_port  = 53
    to_port    = 53
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  ingress {
    description = "Allow coredns communications within cluster"
    protocol   = "tcp"
    from_port  = 30000
    to_port    = 32762
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-frontend_node-sg"
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
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

    description = "Allow ssh communication"
    protocol   = "tcp"
    #cidr_block = "10.50.10.0/24"
    security_groups = [aws_security_group.bastion_sg.id]
    from_port  = 22
    to_port    = 22
  }

  ingress {
    description = "Allow proxy service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 8082
    to_port    = 8082
  }

  ingress {
    description = "Allow auth service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 9000
    to_port    = 9000
  }

  ingress {
    description = "Allow  vp service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 9002
    to_port    = 9002
  }

  ingress {
    description = "Allow umm service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 9003
    to_port    = 9003
  }

  ingress {
    description = "Allow tenant service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 9004
    to_port    = 9004
  }

  ingress {
    description = "Allow integration service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 9006
    to_port    = 9006
  }

  ingress {
    description = "Allow common service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 9008
    to_port    = 9008
  }

  ingress {
    description = "Allow message service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 5020
    to_port    = 5020
  }

  ingress {
    description = "Allow payment service communication"
    protocol   = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
    from_port  = 5060
    to_port    = 5060
  }

  ingress {
    description = "Allow coredns communications within cluster"
    protocol   = "udp"
    from_port  = 53
    to_port    = 53
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  ingress {
    description = "Allow coredns communications within cluster"
    protocol   = "tcp"
    from_port  = 53
    to_port    = 53
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  ingress {
    description = "Allow EKS worker nodes to communicate with EFS via NFS"
    protocol   = "tcp"
    from_port  = 2049
    to_port    = 2049
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-backend_node-sg"
    Env  = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }

}

resource "aws_security_group" "main_backend_node_rds_sg" {

  name        = "${var.vpc_name}_backend_node_rds_sg"
  description = "Security group for the EKS nodes to connect to rds"
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}_backend_node_rds_sg"
    Env  = var.env
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.main_private_rds_subnet_1.cidr_block, aws_subnet.main_private_rds_subnet_2.cidr_block]
  }
}

resource "aws_launch_template" "frontend_launch_template" {
  name          = "frontend-node-launch-template"
  #image_id      = var.frontend_node_group_ami  # Use the appropriate AMI
  #instance_type = "t3.medium"
  key_name      = var.node_ssh_key_name


  network_interfaces {
    security_groups = [aws_security_group.eks_frontend_node_group_sg.id]  # Attach security group here
  }

  # Propagate tags to EC2 instances
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${aws_eks_cluster.main_eks_cluster.name}-frontend-node"  # Ensures Name tag appears on EC2 instances
      Env  = var.env
      "kubernetes.io/cluster/${aws_eks_cluster.main_eks_cluster.name}" = "owned"
    }
  }

}

resource "aws_launch_template" "backend_launch_template" {
  name     = "backend-node-launch-template"
  #image_id = var.backend_node_group_ami  # Use the appropriate AMI
  #instance_type = "t3.large"
  key_name = var.node_ssh_key_name


  network_interfaces {
    security_groups = [aws_security_group.eks_backend_node_group_sg.id, aws_security_group.main_backend_node_rds_sg.id]
    # Attach security group here
  }

  # Propagate tags to EC2 instances
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name                                                             = "${aws_eks_cluster.main_eks_cluster.name}-backend-node"
      # Ensures Name tag appears on EC2 instances
      Env                                                              = var.env
      "kubernetes.io/cluster/${aws_eks_cluster.main_eks_cluster.name}" = "owned"
    }
  }
}

resource "kubernetes_config_map" "aws_auth" {
  depends_on = [aws_eks_cluster.main_eks_cluster]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<EOF
- rolearn: ${aws_iam_role.eks_node_role.arn}
  username: system:node:{{EC2PrivateDNS}}
  groups:
    - system:bootstrappers
    - system:nodes
EOF

    mapUsers = <<EOF
- userarn: arn:aws:iam::194978441177:user/viraj.a
  username: viraj.a
  groups:
    - system:masters
EOF
  }

  # Prevent Terraform from attempting to recreate this resource
  lifecycle {
    ignore_changes = all
  }
}


