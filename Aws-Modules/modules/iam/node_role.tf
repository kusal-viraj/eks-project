# IAM Role for EKS Node Groups
resource "aws_iam_role" "eks_node_role" {
  name = "${var.env_name}-eks-node-role"

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

}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "container_registry_read_only" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}



# Additional Inline Policy for EFS Access
resource "aws_iam_policy" "efs_access_policy" {
  name        = "${var.env_name}-EFSAccessPolicy"
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

