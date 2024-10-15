
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



variable "bastion_subnet_cidr" {
  type        = string
  description = "public subnet"
}



variable "public_subnet_1_cidr" {
  type        = string
  description = "public subnet"
}



variable "public_subnet_2_cidr" {
  type        = string
  description = "public subnet"
}


variable "private_app_subnet_1_cidr" {
  type        = string
  description = "public subnet"
}



variable "private_app_subnet_2_cidr" {
  type        = string
  description = "public subnet"
}



variable "private_rds_subnet_1_cidr" {
  type        = string
  description = "public subnet"
}


variable "private_rds_subnet_2_cidr" {
  type        = string
  description = "public subnet"
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
  type        = string
  description = "IP of the vpn"
}


#====RDS Module=========================================================================

variable "db_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
}

variable "db_allocated_storage" {
  description = "Size of the RDS instance storage (in GB)"
  type        = number
  default     = 20
}

variable "db_engine" {
  description = "The database engine (e.g., mysql, postgres)"
  type        = string
  default     = "mariadb"
}

variable "snapshot" {
  description = "The database engine (e.g., mysql, postgres)"
  type        = string
  default     = "mariadb"
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

variable "db_port" {
  description = "The port for the RDS instance"
  type        = number
  default     = 5432
}

variable "db_multi_az" {
  description = "Whether to deploy the RDS instance in multiple AZs"
  type        = bool
  default     = false
}

variable "db_backup_retention" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

variable "db_storage_type" {
  description = "The storage type (e.g., gp2, io1)"
  type        = string
  default     = "gp2"
}

variable "final_snapshot" {
  description = "Whether to create final snapshot of the RDS instance"
  type        = bool
  default     = true
}


#==================================================================================
