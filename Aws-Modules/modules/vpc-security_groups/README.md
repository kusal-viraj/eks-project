# Security Groups Module

This module manages AWS Security Groups for various components of the EKS cluster.

## Features

- Creates security groups for:
  - EKS cluster control plane
  - Frontend node groups
  - Backend node groups
  - ALB
  - RDS instances
- Configurable inbound and outbound rules
- Support for custom CIDR blocks and security group references

## Usage

```hcl
module "security_group" {
  source = "../../modules/vpc-security_groups"

  vpc_id = module.vpc.vpc_id
  env_name = var.env_name
  vpn_ip = var.vpn_ip
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
| vpc_id | VPC ID | string | yes |
| env_name | Environment name | string | yes |
| vpn_ip | VPN IP for restricted access | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| eks_cluster_sg_id | Security group ID for EKS cluster |
| frontend_node_sg_id | Security group ID for frontend nodes |
| backend_node_sg_id | Security group ID for backend nodes |
| alb_sg_id | Security group ID for ALB |
