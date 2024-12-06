variable "bastion_ami_id" {
  description = "AMI ID for the EC2 instance."
  type        = string
}

variable "bastion_instance_type" {
  description = "Type of the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "Bastion_key_name" {
  description = "EC2 key pair name."
  type        = string
}

variable "bastion_subnet_id" {
  description = "The subnet ID where the instance will be deployed."
  type        = string
}

#variable "instance_name" {
#  description = "The name of the EC2 instance."
#  type        = string
#}


variable "bastion_sg_id" {
  description = "List of security group IDs to associate with the instance."
  type        = string

}

variable  "env_name" {type = string}
