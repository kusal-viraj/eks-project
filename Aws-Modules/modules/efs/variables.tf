variable  "env_name" {type = string}


#variable "vpc_id" {
#  description = "The VPC ID for the NACL."
#  type        = string
#}

variable "efs_subnet_ids" {
  description = "The VPC ID for the NACL."
  type        = list
}

variable "efs_sg_id" {
  description = "The VPC ID for the NACL."
  type        = string
}
