
## source = "../Aws-Modules/modules/eks/eks.tf"
## EKS Cluster

#=======================================================================

resource "aws_eks_cluster" "main_eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids = [var.public_subnet_az_01,var.public_subnet_az_02,var.app_subnet_az_01,var.app_subnet_az_02]  # Public subnets for frontend
    #subnet_ids = [module.vpc.main_public_subnet_1,module.vpc.main_public_subnet_2,module.vpc.main_private_app_subnet_1,module.vpc.main_private_app_subnet_2]

    endpoint_private_access = true
    endpoint_public_access  = true

    # Cluster security group
    security_group_ids = [var.eks_cluster_sg_id]


  }

  tags = {
    Name = "${var.env_name}-eks-cluster"
    Env  = var.env_name
  }
}


# Data source to find the control plane security group
data "aws_security_group" "eks_control_plane" {
  filter {
    name   = "tag:aws:eks:cluster-name"
    values = [aws_eks_cluster.main_eks_cluster.name]
  }
}



resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn = var.eks_node_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])

    mapUsers = yamlencode([
      for user in var.additional_users : {
        userarn  = "arn:aws:iam::${var.account_id}:user/${user}"
        username = user
        groups   = ["system:masters"]
      }
    ])
  }
}


data "aws_eks_cluster" "my_eks_cluster" {
  name = aws_eks_cluster.main_eks_cluster.name
}

data "aws_eks_cluster_auth" "my_eks_cluster" {
  name = aws_eks_cluster.main_eks_cluster.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.my_eks_cluster.endpoint
  token                  = data.aws_eks_cluster_auth.my_eks_cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.my_eks_cluster.certificate_authority[0].data)
  config_path = "~/.kube/config"
}


#resource "aws_eks_addon" "efs_csi_driver" {
#  cluster_name = aws_eks_cluster.main_eks_cluster.name
#  addon_name   = "efs_csi_driver"
#}
