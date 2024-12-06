#output "cluster_name" {
#  description = "The ID of the security group."
#  value       = aws_eks_cluster.main_eks_cluster.name
#}


output "control_plane_security_group_id" {
  description = "The ID of the security group."
  value       = data.aws_security_group.eks_control_plane.id
}

output "cluster_endpoint" {
  description = "The endpoint of the cluster"
  value       = data.aws_eks_cluster.my_eks_cluster.endpoint
}

output "cluster_ca" {
  description = "The cluster ca"
  value       = data.aws_eks_cluster.my_eks_cluster.certificate_authority[0].data
}
