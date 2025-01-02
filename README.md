# AWS EKS Infrastructure Project

This project contains Terraform modules for deploying a production-ready EKS cluster with supporting infrastructure on AWS.

## Project Structure

```
Aws-Modules/
├── modules/           # Reusable infrastructure components
│   ├── alb/          # Application Load Balancer configurations
│   ├── eks/          # EKS cluster configurations
│   ├── vpc/          # VPC and networking components
│   └── ...
└── env/              # Environment-specific configurations
    ├── qa/           # QA environment
    └── testing/      # Testing environment
```

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials
- kubectl installed for cluster management

## Usage

1. Navigate to the desired environment directory:
```bash
cd Aws-Modules/env/[environment]
```

2. Initialize Terraform:
```bash
terraform init
```

3. Review and apply changes:
```bash
terraform plan
terraform apply
```

## Environments

- **QA**: Quality Assurance environment
- **Testing**: Testing environment

## Module Documentation

Detailed documentation for each module can be found in their respective directories under `Aws-Modules/modules/`.
