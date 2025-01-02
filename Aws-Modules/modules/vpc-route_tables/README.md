# VPC Route Tables Module

This module manages route tables and routing configuration for the VPC.

## Features

- Creates and manages route tables
- Configures routes for:
  - Internet Gateway
  - NAT Gateway
  - VPC Peering
  - Transit Gateway
- Handles subnet associations
- Supports custom route propagation

## Usage

```hcl
module "route_tables" {
  source = "../../modules/vpc-route_tables"

  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc-igw.igw_id
  nat_gateway_id = module.vpc-natgw.nat_gateway_id
  public_subnet_ids = module.vpc-subnets.public_subnet_ids
  private_subnet_ids = module.vpc-subnets.private_subnet_ids
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
| igw_id | ID of the Internet Gateway | string | yes |
| nat_gateway_id | ID of the NAT Gateway | string | yes |
| public_subnet_ids | List of public subnet IDs | list(string) | yes |
| private_subnet_ids | List of private subnet IDs | list(string) | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| public_route_table_id | ID of the public route table |
| private_route_table_id | ID of the private route table |
