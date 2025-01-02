# S3 (Simple Storage Service) Module

This module manages S3 buckets and their configurations.

## Features

- Creates and manages S3 buckets
- Configures bucket policies and access controls
- Manages bucket encryption
- Sets up lifecycle rules
- Configures versioning
- Handles CORS settings
- Supports logging and monitoring

## Usage

```hcl
module "s3" {
  source = "../../modules/s3"

  bucket_name = "${var.env_name}-bucket"
  env_name = var.env_name
  versioning_enabled = true
  encryption_enabled = true
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
| bucket_name | Name of the S3 bucket | string | yes |
| env_name | Environment name | string | yes |
| versioning_enabled | Enable versioning | bool | no |
| encryption_enabled | Enable encryption | bool | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | Name of the bucket |
| bucket_arn | ARN of the bucket |
| bucket_domain_name | Domain name of the bucket |
