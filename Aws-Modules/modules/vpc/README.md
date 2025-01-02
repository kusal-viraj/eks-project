# VPC Module

This module creates a Virtual Private Cloud (VPC) with the necessary networking components.

## Features

- Creates VPC with customizable CIDR block
- Enables DNS hostnames and support
- Configurable instance tenancy
- Supports tagging for resource management

## Usage

```hcl
module "vpc" {
  source = "../../modules/vpc"
  
  region     = var.region
  vpc_cidr   = var.vpc_cidr
  vpc_name   = var.vpc_name
  env_name   = var.env_name
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
| vpc_cidr | CIDR block for VPC | string | yes |
| vpc_name | Name tag for VPC | string | yes |
| env_name | Environment name | string | yes |
| vpc_tenancy | Instance tenancy | string | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the created VPC |
| vpc_cidr | CIDR block of the VPC |
