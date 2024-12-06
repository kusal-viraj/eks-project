variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
}

variable "igw_id" {
  type = string
}

variable "public_subnet_az1_id" {
  type = string
}

variable "public_subnet_az2_id" {
  type = string
}


variable "app_subnet_az1_id" {
  type = string
}

variable "app_subnet_az2_id" {
  type = string
}

variable "rds_subnet_az1_id" {
  type = string
}

variable "rds_subnet_az2_id" {
  type = string
}

variable "bastion_subnet_id" {
  type = string
}


variable "nat_gw_az1_id" {
  type = string
}

variable "nat_gw_az2_id" {
  type = string
}

variable "env_name" {
  type = string
}
