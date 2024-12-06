variable "region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}

variable "cluster_name" {}
variable "vpc_tenancy" {}
variable "public_bastion_subnet_az_01_cidr" {}
variable "web_public_subnet_az1_cidr" {}
variable "web_public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_rds_subnet_az1_cidr" {}
variable "private_rds_subnet_az2_cidr" {}
variable "env_name" {}
variable "vpn_ip" {}
#variable "node_group_ami" {}


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


variable "proxy_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "auth_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "vp_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "umm_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "tenant_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "integration_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "common_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "message_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "payment_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "bcc_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "qbo_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "usb_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "notification_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "checkeeper_service_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "db_rds_db_port" {
  description = "The VPC cidr block ."
  type        = number
}

variable "node_ssh_key_name" {
  type        = string
  description = "IP of the vpn"
}



variable "db_allocated_storage" {
  description = "The size of the RDS instance storage in GB"
  type        = number
  default     = 20
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgres, etc.)"
  type        = string
  default     = "postgres"
}

variable "db_snapshot_id" {
  description = "The database engine to use (e.g., mysql, postgres, etc.)"
  type        = string
  default     = "postgres"
}



variable "db_engine_version" {
  description = "The database engine (e.g., mysql, postgres)"
  type        = string
  default     = "10.11.4"
}

variable "db_instance_class" {
  description = "The instance class (e.g., db.t3.micro, db.t3.medium)"
  type        = string
  default     = "db.t3.micro"
}



variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
}


variable "db_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when the instance is deleted"
  type        = bool
  default     = true
}

variable "db_storage_type" {
  description = "The storage type to use (e.g., gp2, io1)"
  type        = string
  default     = "gp2"
}

variable "db_multi_az" {
  description = "Whether to deploy the RDS instance across multiple Availability Zones"
  type        = bool
  default     = false
}

variable "db_backup_retention" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "acm_certificate_arn" {
  description = "The cert arn"
  type        = string
}

variable "account_id" {
  type = string
}

variable "additional_users" {
  description = "List of IAM users to add to the EKS cluster with access"
  type        = list(string)
  default     = []
}
