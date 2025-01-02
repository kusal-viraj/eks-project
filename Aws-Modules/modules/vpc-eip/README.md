# VPC Elastic IP Module

This module manages Elastic IP addresses for the VPC resources.

## Features

- Allocates and manages Elastic IP addresses
- Supports EIP association with EC2 instances or Network Interfaces
- Handles EIP tagging
- Configures domain type (VPC/Standard)

## Usage

```hcl
module "eip" {
  source = "../../modules/vpc-eip"

  name = "${var.env_name}-nat-eip"
  instance_id = module.ec2.instance_id  # Optional
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
| name | Name tag for the EIP | string | yes |
| instance_id | ID of EC2 instance to associate with | string | no |
| network_interface_id | ID of ENI to associate with | string | no |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Allocation ID of the EIP |
| public_ip | Public IP address |
| private_ip | Private IP address (if associated) |
