variable  "env_name" {
  type = string
}

variable  "cluster_name" {
  type = string
}

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "alb_sg_id" {
  description = "The VPC ID."
  type        = string
}

variable "public_subnet_az_01_id" {
  description = "The VPC ID."
  type        = string
}


variable "public_subnet_az_02_id" {
  description = "The VPC ID."
  type        = string
}


variable "acm_certificate_arn" {
  description = "The cert arn"
  type        = string
}
