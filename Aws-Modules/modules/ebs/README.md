# EBS (Elastic Block Store) Module

This module manages AWS EBS volumes for persistent storage.

## Features

- Creates EBS volumes with configurable sizes
- Supports multiple volume types (gp2, gp3, io1, etc.)
- Manages volume encryption
- Handles volume tagging and snapshots

## Usage

```hcl
module "ebs" {
  source = "../../modules/ebs"

  availability_zone = data.aws_availability_zones.available.names[0]
  size             = 100
  volume_type      = "gp3"
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
| availability_zone | AZ where the volume will be created | string | yes |
| size | Size of the volume in GiB | number | yes |
| volume_type | Type of EBS volume | string | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| volume_id | ID of the created EBS volume |
| volume_arn | ARN of the EBS volume |
