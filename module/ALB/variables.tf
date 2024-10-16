# Step 1: Define the VPC and Subnets (assumed to exist)
variable "vpc_id" {
  description = "VPC where EFS will be created"
}


variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}


variable "public_subnets" {
  type = list
  description = "Name of the VPC"
}

