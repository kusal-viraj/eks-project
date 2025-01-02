# Launch Templates Module

This module manages EC2 launch templates for EKS node groups.

## Features

- Separate launch templates for frontend and backend nodes
- Customizable instance types and AMIs
- User data script configuration
- Security group assignments

## Usage

```hcl
module "launch_templates" {
  source = "../../modules/launch_templates"

  node_ssh_key_name = var.node_ssh_key_name
  env_name = var.env_name
  cluster_name = var.cluster_name
  frontend_node_sg_id = module.security_group.frontend_node_sg_id
  backend_node_sg_id = module.security_group.backend_node_sg_id
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
| node_ssh_key_name | SSH key name for nodes | string | yes |
| env_name | Environment name | string | yes |
| cluster_name | EKS cluster name | string | yes |
| frontend_node_sg_id | Security group ID for frontend nodes | string | yes |
| backend_node_sg_id | Security group ID for backend nodes | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| frontend_launch_template_id | ID of frontend launch template |
| backend_launch_template_id | ID of backend launch template |
