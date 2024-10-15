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
output "Bastion_Instance_Public_Ip" {
  value = module.vpc.bastion_instance_public_ip
}

output "EFS_Filesystem_ID" {
  value = module.efs.efs_file_system_id
}



