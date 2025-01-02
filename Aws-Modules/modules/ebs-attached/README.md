# EBS Attachment Module

This module manages the attachment of EBS volumes to EC2 instances.

## Features

- Manages EBS volume attachments to EC2 instances
- Supports multiple volume attachments
- Configurable device names
- Handles force detachment options

## Usage

```hcl
module "ebs_attached" {
  source = "../../modules/ebs-attached"

  instance_id = module.ec2.instance_id
  volume_id   = module.ebs.volume_id
  device_name = "/dev/xvdf"
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
| instance_id | ID of the EC2 instance | string | yes |
| volume_id | ID of the EBS volume | string | yes |
| device_name | Device name to expose to the instance | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| attachment_id | ID of the volume attachment |
| device_name | Device name used for attachment |
