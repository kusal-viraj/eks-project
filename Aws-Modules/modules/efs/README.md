# EFS (Elastic File System) Module

This module manages AWS EFS file systems for persistent shared storage.

## Features

- Creates EFS file systems with configurable performance modes
- Manages mount targets in multiple availability zones
- Configures security groups for EFS access
- Supports encryption at rest
- Handles backup policies and lifecycle management

## Usage

```hcl
module "efs" {
  source = "../../modules/efs"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc-subnets.private_subnet_ids
  security_group_ids = [module.security_group.efs_sg_id]
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
| vpc_id | VPC ID where EFS will be created | string | yes |
| subnet_ids | List of subnet IDs for mount targets | list(string) | yes |
| security_group_ids | List of security group IDs | list(string) | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| efs_id | ID of the EFS file system |
| efs_arn | ARN of the EFS file system |
| mount_targets | List of mount target IDs |
| dns_name | DNS name of the EFS file system |
