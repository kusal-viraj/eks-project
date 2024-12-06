cluster_name   = "testing-vpc-eks-cluster"
vpc_name       = "020_TESTING_VPC"
region         = "us-east-2"
env_name       = "testing-vpc"
vpc_cidr       = "10.20.0.0/16"
vpc_tenancy    = "default"

public_bastion_subnet_az_01_cidr = "10.20.10.0/24"

web_public_subnet_az1_cidr = "10.20.11.0/24"
web_public_subnet_az2_cidr = "10.20.12.0/24"

private_app_subnet_az1_cidr = "10.20.21.0/24"
private_app_subnet_az2_cidr = "10.20.22.0/24"

private_rds_subnet_az1_cidr = "10.20.31.0/24"
private_rds_subnet_az2_cidr = "10.20.32.0/24"


bastion_ami_id        = "ami-05c3dc660cb6907f0"
#bastion_instance_name = "dev_vpc_bastion_instance"
Bastion_key_name      = "Papertrl_EC2_viraj"
bastion_instance_type = "t2.micro"

vpn_ip                  = "3.13.112.140/32"
#node_group_ami          = "ami-0472ba5c5503e36cb"
#frontend_node_group_ami = "ami-0490fddec0cbeb88b"
#backend_node_group_ami  = "ami-0490fddec0cbeb88b"
node_ssh_key_name       = "Papertrl_EC2_viraj"


#===RDS=======

db_username          = "papertrl"
db_password          = "ptmariadbcom"
db_allocated_storage = "20"
db_engine            = "mariadb" # Use engine name only
db_engine_version    = "10.11.4"
db_instance_class    = "db.m6gd.large"
db_rds_db_port       = "3306"
db_multi_az          = "false"
db_backup_retention  = "7"
db_storage_type      = "gp3"
#final_snapshot       = "true"
#snapshot             = "rds:restore-2024-10-14-08-13"



#====================================================

proxy_service_port       = "7000"
auth_service_port        = "6000"
umm_service_port         = "5040"
tenant_service_port      = "5030"
vp_service_port          = "5050"
integration_service_port = "5010"
common_service_port      = "5000"
message_service_port     = "5020"
payment_service_port     = "5060"

bcc_service_port          = "9010"
qbo_service_port          = "9000"

usb_service_port          = "10000"
notification_service_port = "10100"
checkeeper_service_port   = "10200"

acm_certificate_arn = ""

account_id = "194978441177"
additional_users = ["viraj.a","EKS_User"]
