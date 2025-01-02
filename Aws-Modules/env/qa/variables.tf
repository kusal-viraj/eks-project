variable "region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "vpc_tenancy" {}

variable "cluster_name" {}
variable "public_bastion_subnet_az_01_cidr" {}
variable "web_public_subnet_az1_cidr" {}
variable "web_public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_rds_subnet_az1_cidr" {}
variable "private_rds_subnet_az2_cidr" {}
variable "env_name" {}
variable "vpn_ip" {}

variable "node_ssh_key_name" {
  type        = string
  description = "SSH key name for the worker nodes"
}

variable "bastion_ami_id" {
  type        = string
  description = "AMI of the bastion instance"
}

variable "bastion_instance_type" {
  type        = string
  description = "Instance type"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "additional_users" {
  type        = list(string)
  description = "List of additional IAM users to add to the aws-auth configmap"
  default     = []
}

# Service Ports
variable "proxy_service_port" {
  type        = number
  description = "Port for proxy service"
}

variable "auth_service_port" {
  type        = number
  description = "Port for auth service"
}

variable "vp_service_port" {
  type        = number
  description = "Port for vp service"
}

variable "tenant_service_port" {
  type        = number
  description = "Port for tenant service"
}
