# EC2 Module

This module manages EC2 instances, primarily for bastion hosts and utility servers.

## Features

- Creates EC2 instances with configurable instance types
- Supports custom AMIs
- Manages instance profiles and IAM roles
- Configures security groups and network interfaces
- Handles user data scripts
- Supports instance tagging

## Usage

```hcl
module "ec2" {
  source = "../../modules/ec2"

  ami_id           = var.bastion_ami_id
  instance_type    = var.bastion_instance_type
  subnet_id        = module.vpc-subnets.public_subnet_az_01_id
  security_groups  = [module.security_group.bastion_sg_id]
  key_name         = var.Bastion_key_name
  env_name         = var.env_name
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| ami_id | AMI ID for the instance | string | yes |
| instance_type | EC2 instance type | string | yes |
| subnet_id | Subnet ID where instance will be launched | string | yes |
| security_groups | List of security group IDs | list(string) | yes |
| key_name | Name of the SSH key pair | string | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | ID of the created EC2 instance |
| private_ip | Private IP of the instance |
| public_ip | Public IP of the instance (if applicable) |
