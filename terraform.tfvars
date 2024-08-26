cluster_name   = "dev_cluster"
vpc_name       = "dev_vpc"
env            = "dev"
vpc_cidr_block = "10.50.0.0/16"
vpc_tenancy    = "default"
igw_name       = "dev_vpc_igw"

nat_gw_1 = "dev_vpc_nat_gw_1"
nat_gw_2 = "dev_vpc_nat_gw_2"

bastion_subnet_name = "dev_vpc_bastion_subnet"
bastion_subnet_cidr = "10.50.10.0/24"

public_subnet_1_name = "dev_vpc_public_subnet_1"
public_subnet_1_cidr = "10.50.11.0/24"

public_subnet_2_name = "dev_vpc_public_subnet_2"
public_subnet_2_cidr = "10.50.12.0/24"

private_app_subnet_1_name = "dev_vpc_private_app_subnet_1"
private_app_subnet_1_cidr = "10.50.21.0/24"

private_app_subnet_2_name = "dev_vpc_private_app_subnet_2"
private_app_subnet_2_cidr = "10.50.22.0/24"

private_rds_subnet_1_name = "dev_vpc_private_rds_subnet_1"
private_rds_subnet_1_cidr = "10.50.31.0/24"

private_rds_subnet_2_name = "dev_vpc_private_rds_subnet_2"
private_rds_subnet_2_cidr = "10.50.32.0/24"

public_rt    = "dev_vpc_public_rt"
private_rt_1 = "dev_vpc_private_rt_1"
private_rt_2 = "dev_vpc_private_rt_2"


eip_1 = "dev_vpc_eip_1"
eip_2 = "dev_vpc_eip_2"

bastion_nacl     = "dev_vpc_bastion_nacl"
public_nacl      = "dev_vpc_public_nacl"
private_app_nacl = "dev_vpc_private_app_nacl"
private_rds_nacl = "dev_vpc_private_rds_nacl"


bastion_sg_name = "bastion_sg"
bastion_ami_id  = "ami-05c3dc660cb6907f0"
#bastion_ami_id        = "ami-081ab96039f6d465d"
bastion_instance_name = "dev_vpc_bastion_instance"
Bastion_key_name      = "Papertrl_EC2_viraj"
bastion_instance_type = "t2.micro"

vpn_ip                  = "3.13.112.140/32"
frontend_node_group_ami = "ami-0490fddec0cbeb88b"
backend_node_group_ami  = "ami-0490fddec0cbeb88b"
