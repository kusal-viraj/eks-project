cluster_name   = "dev_eks_cluster"
vpc_name       = "dev_vpc"
env            = "dev"
vpc_cidr_block = "10.50.0.0/16"
vpc_tenancy    = "default"





bastion_subnet_cidr = "10.50.10.0/24"


public_subnet_1_cidr = "10.50.11.0/24"


public_subnet_2_cidr = "10.50.12.0/24"


private_app_subnet_1_cidr = "10.50.21.0/24"


private_app_subnet_2_cidr = "10.50.22.0/24"


private_rds_subnet_1_cidr = "10.50.31.0/24"


private_rds_subnet_2_cidr = "10.50.32.0/24"






bastion_sg_name = "bastion_sg"
bastion_ami_id  = "ami-05c3dc660cb6907f0"
#bastion_ami_id        = "ami-081ab96039f6d465d"
bastion_instance_name = "dev_vpc_bastion_instance"
Bastion_key_name      = "Papertrl_EC2_viraj"
bastion_instance_type = "t2.micro"

vpn_ip                  = "3.13.112.140/32"
#frontend_node_group_ami = "ami-0490fddec0cbeb88b"
#backend_node_group_ami  = "ami-0490fddec0cbeb88b"
node_ssh_key_name       = "Papertrl_EC2_viraj"
