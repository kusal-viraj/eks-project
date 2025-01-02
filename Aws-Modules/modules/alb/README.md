# Application Load Balancer (ALB) Module

This module creates and manages Application Load Balancers for the EKS cluster.

## Features

- Creates ALB with configurable settings
- Manages target groups and listeners
- Supports SSL/TLS termination
- Configurable health checks

## Usage

```hcl
module "alb" {
  source = "../../modules/alb"

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc-subnets.public_subnet_ids
  security_groups = [module.security_group.alb_sg_id]
  
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
| vpc_id | VPC ID | string | yes |
| subnets | List of subnet IDs | list(string) | yes |
| security_groups | List of security group IDs | list(string) | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb_arn | ARN of the created ALB |
| alb_dns_name | DNS name of the ALB |
| target_group_arns | List of target group ARNs |
