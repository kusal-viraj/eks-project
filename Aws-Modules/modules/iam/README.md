# IAM Module

This module manages IAM roles and policies for EKS cluster and nodes.

## Features

- Creates cluster service role for EKS
- Creates node IAM role for worker nodes
- Attaches necessary AWS managed policies
- Supports custom IAM policies

## Usage

```hcl
module "iam" {
  source = "../../modules/iam"
  
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
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster_role_arn | ARN of the EKS cluster role |
| node_role_arn | ARN of the EKS node role |
