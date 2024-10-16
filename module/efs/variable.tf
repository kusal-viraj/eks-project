# Step 1: Define the VPC and Subnets (assumed to exist)
variable "vpc_id" {
  description = "VPC where EFS will be created"
}

variable "efs_subnet_ids" {
  description = "Subnets where EFS mount targets will be created"
  type        = list(string)
}


variable "env" {
  type = string
  description = "Name of the env"
}

variable "backend_nodegroup_sg_id" {
  type = list
  description = "Name of the backend sg"
}


