# VPC Internet Gateway Module

This module manages the Internet Gateway for VPC internet connectivity.

## Features

- Creates and manages Internet Gateway
- Handles IGW attachment to VPC
- Configures tagging
- Supports multiple VPC configurations

## Usage

```hcl
module "igw" {
  source = "../../modules/vpc-igw"

  vpc_id = module.vpc.vpc_id
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
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| igw_id | ID of the Internet Gateway |
| igw_arn | ARN of the Internet Gateway |
