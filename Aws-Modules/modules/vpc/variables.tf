variable "region" {
  //type        = string
  //default     = ""
  //escription = "description"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

variable "vpc_tenancy" {
  type = string
  description = "Tenancy of the VPC (default, dedicated)"
}

variable "env_name" {
  type = string
  description = "Name of the env"
}
