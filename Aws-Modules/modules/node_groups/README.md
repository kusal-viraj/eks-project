# EKS Node Groups Module

This module manages EKS node groups for both frontend and backend workloads.

## Features

- Manages separate node groups for frontend and backend workloads
- Configurable instance types and scaling options
- Supports custom launch templates
- Automated node group updates and maintenance

## Usage

```hcl
module "frontend_node_groups" {
  source = "../../modules/node_groups/frontend_node_groups"

  cluster_name = var.cluster_name
  env_name = var.env_name
  node_role_arn = module.iam.node_role_arn
  frontend_launch_template_id = module.launch_templates.frontend_launch_template_id
}

module "backend_node_groups" {
  source = "../../modules/node_groups/backend_node_groups"

  cluster_name = var.cluster_name
  env_name = var.env_name
  node_role_arn = module.iam.node_role_arn
  backend_launch_template_id = module.launch_templates.backend_launch_template_id
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
| cluster_name | Name of the EKS cluster | string | yes |
| env_name | Environment name | string | yes |
| node_role_arn | IAM role ARN for nodes | string | yes |
| launch_template_id | Launch template ID | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| node_group_arn | ARN of the node group |
| node_group_id | ID of the node group |
