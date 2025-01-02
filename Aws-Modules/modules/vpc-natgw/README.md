# VPC NAT Gateway Module

This module manages NAT Gateways for private subnet internet access.

## Features

- Creates and manages NAT Gateways
- Handles Elastic IP allocation and association
- Supports multiple AZ deployment
- Configures routing for private subnets
- Manages high availability setup

## Usage

```hcl
module "natgw" {
  source = "../../modules/vpc-natgw"

  subnet_id = module.vpc-subnets.public_subnet_az_01_id
  eip_id = module.eip.id
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
| subnet_id | ID of the subnet for NAT Gateway | string | yes |
| eip_id | ID of the Elastic IP to associate | string | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| nat_gateway_id | ID of the NAT Gateway |
| nat_gateway_public_ip | Public IP of the NAT Gateway |
| nat_gateway_private_ip | Private IP of the NAT Gateway |
