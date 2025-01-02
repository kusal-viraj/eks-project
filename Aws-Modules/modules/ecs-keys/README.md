# EC2 Key Pairs Module

This module manages SSH key pairs for EC2 instances.

## Features

- Creates and manages EC2 key pairs
- Supports importing existing public keys
- Handles key pair naming and tagging
- Optional local storage of private keys

## Usage

```hcl
module "ec2_keys" {
  source = "../../modules/ecs-keys"

  key_name = "${var.env_name}-key"
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
| key_name | Name of the key pair | string | yes |
| env_name | Environment name | string | yes |
| public_key | Optional public key material | string | no |

## Outputs

| Name | Description |
|------|-------------|
| key_name | Name of the created key pair |
| key_pair_id | ID of the key pair |
| public_key_fingerprint | Fingerprint of the public key |
