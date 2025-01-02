# RDS (Relational Database Service) Module

This module manages AWS RDS instances for database services.

## Features

- Creates RDS instances with configurable engine types
- Supports multi-AZ deployment
- Manages parameter groups and option groups
- Configures automated backups and maintenance windows
- Handles encryption and security group settings
- Supports read replicas

## Usage

```hcl
module "rds" {
  source = "../../modules/rds"

  identifier = "${var.env_name}-db"
  engine = "postgres"
  engine_version = "13.7"
  instance_class = "db.t3.medium"
  allocated_storage = 20
  subnet_ids = module.vpc-subnets.database_subnet_ids
  vpc_security_group_ids = [module.security_group.rds_sg_id]
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
| identifier | Unique identifier for the RDS instance | string | yes |
| engine | Database engine type | string | yes |
| engine_version | Engine version | string | yes |
| instance_class | Instance type for the RDS instance | string | yes |
| allocated_storage | Size of the database in GB | number | yes |
| subnet_ids | List of subnet IDs for DB subnet group | list(string) | yes |
| vpc_security_group_ids | List of VPC security group IDs | list(string) | yes |
| env_name | Environment name | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | Connection endpoint |
| arn | ARN of the RDS instance |
| id | ID of the RDS instance |
| port | Port the database is listening on |
