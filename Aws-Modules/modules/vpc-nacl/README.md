# VPC Network ACL Module

This module manages Network Access Control Lists (NACLs) for VPC subnets.

## Features

- Creates and manages Network ACLs
- Configures inbound and outbound rules
- Supports subnet associations
- Handles rule numbering and priorities
- Implements network security at subnet level

## Usage

```hcl
module "nacl" {
  source = "../../modules/vpc-nacl"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc-subnets.all_subnet_ids
  env_name = var.env_name
  
  inbound_rules = {
    100 = {
      protocol   = "tcp"
      from_port  = 80
      to_port    = 80
      cidr_block = "0.0.0.0/0"
      action     = "allow"
    }
  }
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
| subnet_ids | List of subnet IDs to associate | list(string) | yes |
| env_name | Environment name | string | yes |
| inbound_rules | Map of inbound rules | map(any) | no |
| outbound_rules | Map of outbound rules | map(any) | no |

## Outputs

| Name | Description |
|------|-------------|
| nacl_id | ID of the Network ACL |
| nacl_arn | ARN of the Network ACL |
