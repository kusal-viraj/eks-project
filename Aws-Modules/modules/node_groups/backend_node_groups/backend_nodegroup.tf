



# Backend Node Group - Managed Node Group
resource "aws_eks_node_group" "backend_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "backend-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = [var.backend_private_subnet_az_01_id,var.backend_private_subnet_az_02_id]

  launch_template {
    id      = var.backend_launch_template_id
    version = "$Latest"

  }

  scaling_config {
    desired_size = 5
    min_size     = 2
    max_size     = 6
  }

  instance_types = ["t3.large"]

  tags = {
    Name = "${var.env_name}-backend-node-group"
    Env  = var.env_name
#    Env  = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
  }

#  labels = {
#    Name = "${var.cluster_name}_backend_node"
#  }


  capacity_type = "ON_DEMAND" # Can also be "SPOT" for spot instances

  # Optional: Disk size for nodes (in GiB)
  #disk_size = 20

  update_config {
    max_unavailable = 1
  }

  depends_on = [var.cluster_name]


}
