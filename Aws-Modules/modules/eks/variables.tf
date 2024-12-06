variable "env_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "eks_node_role_arn" {
  type = string
}

variable "eks_cluster_sg_id" {
  type = string
}

variable "public_subnet_az_01" {
  type = string
}

variable "public_subnet_az_02" {
  type = string
}

variable "app_subnet_az_01" {
  type = string
}

variable "app_subnet_az_02" {
  type = string
}

variable "account_id" {
  type = string
}

variable "additional_users" {
  description = "List of IAM users to add to the EKS cluster with access"
  type        = list(string)
  default     = []
}

