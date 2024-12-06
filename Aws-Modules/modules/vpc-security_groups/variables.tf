variable "cluster_name" {
  description = "The name of the security group."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "control_plane_security_group_id" {
  description = "The VPC ID."
  type        = string
}

variable "vpn_ip" {
  description = "Ip Address of the VPN"
  type        = string
}

variable  "env_name" {
  type = string
}


variable "vpc_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
}

variable "rds_subnet_1_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
}

variable "rds_subnet_2_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
}

variable "app_subnet_1_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
}

variable "app_subnet_2_cidr_block" {
  description = "The VPC cidr block ."
  type        = string
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

variable "rds_db_port" {
  description = "The VPC cidr block ."
  type        = number
}
