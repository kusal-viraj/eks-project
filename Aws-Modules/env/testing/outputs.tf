## ./module/vpc/outputs.tf
#
#output "vpc_id" {
#  value = aws_vpc.main_vpc.id
#}
#
#output "main_public_subnet_1" {
#  value = aws_subnet.main_public_subnet_1.id
#}
#
#output "main_public_subnet_2" {
#  value = aws_subnet.main_public_subnet_2.id
#}
#
#output "main_private_app_subnet_1" {
#  value = aws_subnet.main_private_app_subnet_1.id
#}
#
#output "main_private_app_subnet_2" {
#  value = aws_subnet.main_private_app_subnet_2.id
#}
#
#output "vpc_cidr_block" {
#  value = aws_vpc.main_vpc.cidr_block
#}
#
output "Testing_SSH_Instance_Public_Ip" {
  value = module.ec2.ssh_Instance_public_IP
}

output "Testing_EFS_Filesystem_ID" {
  value = module.efs.efs_file_system_id
}


output "Testing_Rds_Instance_endpoint" {
  value = module.rds.rds_endpoint
}


output "Testing_ALB_DNS_Name" {
  value = module.alb.alb_dns_name
}


output "Testing_ALB_ARN" {
  value = module.alb.alb_arn_name
}

output "Testing_ALB_Targetgroup_ARN" {
  value = module.alb.alb_targetgroup_arn
}

output "Testing_EKS_Cluster_Name" {
  value = var.cluster_name
}

