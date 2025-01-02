region="ap-south-1"
vpc_cidr="10.22.0.0/16"
vpc_name="022.QA-VPC"
public_bastian_subnet_cidr_az_01="10.22.101.0/24"
web_public_subnet_cidr_01 = "10.22.11.0/24"
web_public_subnet_cidr_02 = "10.22.12.0/24"
private_subnet_cidr_01 = "10.22.21.0/24"
private_subnet_cidr_02 = "10.22.22.0/24"
env_name = "022.QA-VPC"



region                  = "<your-aws-region>"
vpc_cidr                = "<vpc-cidr-block>"  # e.g., "10.0.0.0/16"
vpc_name                = "<vpc-name>"
vpc_tenancy             = "default"
cluster_name            = "<eks-cluster-name>"

# Subnet CIDR blocks
public_bastion_subnet_az_01_cidr = "<cidr>"  # e.g., "10.0.1.0/24"
web_public_subnet_az1_cidr       = "<cidr>"  # e.g., "10.0.2.0/24"
web_public_subnet_az2_cidr       = "<cidr>"  # e.g., "10.0.3.0/24"
private_app_subnet_az1_cidr      = "<cidr>"  # e.g., "10.0.4.0/24"
private_app_subnet_az2_cidr      = "<cidr>"  # e.g., "10.0.5.0/24"
private_rds_subnet_az1_cidr      = "<cidr>"  # e.g., "10.0.6.0/24"
private_rds_subnet_az2_cidr      = "<cidr>"  # e.g., "10.0.7.0/24"

env_name                = "qa"
vpn_ip                 = "<your-vpn-ip>"
node_ssh_key_name      = "<your-ssh-key-name>"
bastion_ami_id         = "<ami-id>"
bastion_instance_type  = "t2.micro"  # or your preferred instance type
account_id             = "<your-aws-account-id>"

# Service Ports
proxy_service_port     = 8080
auth_service_port      = 8081
vp_service_port        = 8082
tenant_service_port    = 8083