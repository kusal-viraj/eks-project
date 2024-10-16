# ./module/vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "main_public_subnet_1" {
  value = aws_subnet.main_public_subnet_1.id
}

output "main_public_subnet_2" {
  value = aws_subnet.main_public_subnet_2.id
}

output "public_subnets" {
  description = "The private RDS subnets for the VPC"
  value       = [
    aws_subnet.main_public_subnet_1,
    aws_subnet.main_public_subnet_2
  ]
}


output "main_private_app_subnet_1" {
  value = aws_subnet.main_private_app_subnet_1.id
}

output "main_private_app_subnet_2" {
  value = aws_subnet.main_private_app_subnet_2.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
}

#output "bastion_subnet_cidr" {
#  value = aws_subnet.bastion_subnet_cidr
#}

output "private_rds_subnet_ids" {
  description = "The private RDS subnets for the VPC"
  value       = [
    aws_subnet.main_private_rds_subnet_1.id,
    aws_subnet.main_private_rds_subnet_2.id
  ]
}

output "private_app_subnet" {
  description = "The private RDS subnets for the VPC"
  value       = [
    aws_subnet.main_private_app_subnet_1.cidr_block,
    aws_subnet.main_private_app_subnet_2.cidr_block
  ]
}

output "private_app_subnet_ids" {
  description = "The private RDS subnets for the VPC"
  value       = [
    aws_subnet.main_private_app_subnet_1.id,
    aws_subnet.main_private_app_subnet_2.id
  ]
}

output "bastion_instance_public_ip" {
  description = "The private RDS subnets for the VPC"
  value       = aws_instance.bastion_instance.public_ip

}

output "backend_nodegroup_sg_id" {
  description = "The private RDS subnets for the VPC"
  value       = aws_security_group.eks_backend_node_group_sg.id

}

output "eks_cluster_name" {
  description = "The private RDS subnets for the VPC"
  value       = aws_eks_cluster.main_eks_cluster.name

}

output "eks_cluster_endpoint" {
  description = "The private RDS subnets for the VPC"
  value       = aws_eks_cluster.main_eks_cluster.endpoint

}

# Inside your VPC module (module/vpc/outputs.tf)
output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.main_eks_cluster.certificate_authority[0].data
}

