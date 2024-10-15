variable "private_rds_subnet_ids" {
  type        = list
  description = "public subnet"
}

variable "cluster_name" {
  type = string
  description = "Name of the cluster"
}

variable "env" {
  type = string
  description = "Name of the env"
}


variable "vpc_id" {
  type = string
  description = "Name of the env"
}

variable "backend_subnet_cidrs" {
  type = list
  description = "Backend app subnets"
}


variable "allocated_storage" {
  description = "The size of the RDS instance storage in GB"
  type        = number
  default     = 20
}

variable "engine" {
  description = "The database engine to use (e.g., mysql, postgres, etc.)"
  type        = string
  default     = "postgres"
}

variable "snapshot_id" {
  description = "The database engine to use (e.g., mysql, postgres, etc.)"
  type        = string
  default     = "postgres"
}



variable "engine_version" {
  description = "The database engine (e.g., mysql, postgres)"
  type        = string
  default     = "10.11.4"
}

variable "instance_class" {
  description = "The instance class (e.g., db.t3.micro, db.t3.medium)"
  type        = string
  default     = "db.t3.micro"
}



variable "username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "port" {
  description = "The port on which the database will listen"
  type        = number
  default     = 5432
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when the instance is deleted"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "The storage type to use (e.g., gp2, io1)"
  type        = string
  default     = "gp2"
}

variable "multi_az" {
  description = "Whether to deploy the RDS instance across multiple Availability Zones"
  type        = bool
  default     = false
}

variable "backup_retention" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}
