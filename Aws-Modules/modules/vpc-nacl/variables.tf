variable "vpc_id" {
  description = "The VPC ID for the NACL."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
}

variable  "env_name" {type = string}

variable "vpn_ip" {
  description = "Ip Address of the VPN"
  type        = string
}



#variable "nacl_name" {
#  description = "The name of the NACL."
#  type        = string
#}


variable "bastion_subnet_id" {
  description = "The name of the NACL."
  type        = string
}

variable "public-subnet-bastion-az_01_cidr" {
  description = "The name of the NACL."
  type        = string
}

variable "public_subnet_az_01_id" {
  description = "The name of the NACL."
  type        = string
}

variable "public_subnet_az_02_id" {
  description = "The name of the NACL."
  type        = string
}


variable "app_subnet_az_01_id" {
  description = "The name of the NACL."
  type        = string
}

variable "app_subnet_az_02_id" {
  description = "The name of the NACL."
  type        = string
}

variable "rds_subnet_az_01_id" {
  description = "The name of the NACL."
  type        = string
}

variable "rds_subnet_az_02_id" {
  description = "The name of the NACL."
  type        = string
}
