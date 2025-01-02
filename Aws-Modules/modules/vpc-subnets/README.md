# VPC Subnets Module

This module manages subnet configurations for the VPC.

## Features

- Creates and manages VPC subnets
- Supports multiple availability zones
- Configures public and private subnets
- Handles subnet CIDR allocation
- Manages subnet tagging for:
  - Kubernetes auto-discovery
  - Load balancer configuration
  - Auto-scaling groups

## Usage

```hcl
module "vpc-subnets" {
  source = "../../modules/vpc-subnets"

  vpc_id = module.vpc.vpc_id
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr
  env_name = var.env_name
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
| vpc_id | ID of the VPC | string | yes |
| public_subnet_az1_cidr | CIDR for public subnet in AZ1 | string | yes |
| public_subnet_az2_cidr | CIDR for public subnet in AZ2 | string | yes |
| private_app_subnet_az1_cidr | CIDR for private app subnet in AZ1 | string | yes |
| private_app_subnet_az2_cidr | CIDR for private app subnet in AZ2 | string | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| public_subnet_az_01_id | ID of public subnet in AZ1 |
| public_subnet_az_02_id | ID of public subnet in AZ2 |
