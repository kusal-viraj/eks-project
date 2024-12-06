output "node_role_arn" {
  description = "The ID of the security group."
  value       = aws_iam_role.eks_node_role.arn
}


output "cluster_role_arn" {
  description = "The ID of the security group."
  value       = aws_iam_role.eks_cluster_role.arn
}
