
variable "cluster_name" {
  type        = string
  description = "Name of the eks cluster"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "env" {
  type        = string
  description = "Name of the env"
}


variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_tenancy" {
  type        = string
  description = "Tenancy of the VPC (default, dedicated)"
}

variable "igw_name" {
  type        = string
  description = "Internet gateway name"
}

variable "bastion_subnet_name" {
  type        = string
  description = "public subnet"
}

variable "bastion_subnet_cidr" {
  type        = string
  description = "public subnet"
}

variable "public_subnet_1_name" {
  type        = string
  description = "public subnet"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "public subnet"
}

variable "public_subnet_2_name" {
  type        = string
  description = "public subnet"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "public subnet"
}

variable "private_app_subnet_1_name" {
  type        = string
  description = "public subnet"
}

variable "private_app_subnet_1_cidr" {
  type        = string
  description = "public subnet"
}

variable "private_app_subnet_2_name" {
  type        = string
  description = "public subnet"
}

variable "private_app_subnet_2_cidr" {
  type        = string
  description = "public subnet"
}

variable "private_rds_subnet_1_name" {
  type        = string
  description = "public subnet"
}

variable "private_rds_subnet_1_cidr" {
  type        = string
  description = "public subnet"
}

variable "private_rds_subnet_2_name" {
  type        = string
  description = "public subnet"
}

variable "private_rds_subnet_2_cidr" {
  type        = string
  description = "public subnet"
}

variable "nat_gw_1" {
  type        = string
  description = "Nat Gateway"
}

variable "nat_gw_2" {
  type        = string
  description = "Nat Gateway"
}

variable "public_rt" {
  type        = string
  description = "Route tables for public subnet"
}

variable "private_rt_1" {
  type        = string
  description = "Route tables for private subnet"
}

variable "private_rt_2" {
  type        = string
  description = "Route tables for private subnet"
}

variable "eip_1" {
  type        = string
  description = "Route tables for private subnet"
}

variable "eip_2" {
  type        = string
  description = "Route tables for private subnet"
}

variable "public_nacl" {
  type        = string
  description = "NACL for public subnet"
}

variable "bastion_nacl" {
  type        = string
  description = "NACL for public subnet"
}

variable "private_app_nacl" {
  type        = string
  description = "NACL for public subnet"
}

variable "private_rds_nacl" {
  type        = string
  description = "NACL for public subnet"
}

variable "bastion_sg_name" {
  type        = string
  description = "security group for the bastion host"
}

variable "vpn_ip" {
  type        = string
  description = "IP of the vpn"
}

variable "bastion_ami_id" {
  type        = string
  description = "AMI  of the bastion instance"
}

variable "bastion_instance_type" {
  type        = string
  description = "Instance type"
}

variable "Bastion_key_name" {
  type        = string
  description = "IP of the vpn"
}

variable "bastion_instance_name" {
  type        = string
  description = "IP of the vpn"
}


variable "frontend_node_group_ami" {
  type        = string
  description = "IP of the vpn"
}

variable "backend_node_group_ami" {
  type        = string
  description = "IP of the vpn"
}

variable "node_ssh_key_name" {
  type = string
  description = "IP of the vpn"
}
