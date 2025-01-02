# EKS Module

This module creates and manages an Amazon Elastic Kubernetes Service (EKS) cluster.

## Features

- Creates EKS cluster with configurable node groups
- Manages cluster IAM roles and policies
- Configures cluster networking and security groups
- Supports custom authentication and authorization

## Usage

```hcl
module "eks" {
  source = "../../modules/eks"

  env_name              = var.env_name
  cluster_name          = var.cluster_name
  eks_cluster_role_arn  = module.iam.cluster_role_arn
  eks_node_role_arn     = module.iam.node_role_arn
  public_subnet_az_01   = module.vpc-subnets.public_subnet_az_01_id
  public_subnet_az_02   = module.vpc-subnets.public_subnet_az_02_id
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | ~> 5.0 |
| kubernetes | ~> 2.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| env_name | Environment name | string | yes |
| cluster_name | Name of the EKS cluster | string | yes |
| eks_cluster_role_arn | ARN of the EKS cluster IAM role | string | yes |
| eks_node_role_arn | ARN of the EKS node IAM role | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | EKS cluster endpoint |
| cluster_ca | EKS cluster certificate authority data |
| cluster_name | Name of the EKS cluster |
