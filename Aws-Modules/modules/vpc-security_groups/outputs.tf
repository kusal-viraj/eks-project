output "ssh_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.bastion_sg.id
}

output "rds_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.main_rds_sg.id
}

output "backend_node_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.eks_backend_node_group_sg.id
}

output "frontend_node_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.eks_frontend_node_group_sg.id
}

output "backend_node_rds_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.main_backend_node_rds_sg.id
}

output "efs_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.main_efs_sg.id
}

output "alb_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.main_alb_sg.id
}

output "eks_cluster_sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.eks_cluster_sg.id
}

