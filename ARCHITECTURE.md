# AWS Architecture Diagram

## Infrastructure Overview

```mermaid
graph TB
    %% Internet and VPC
    Internet((Internet))
    subgraph VPC["VPC"]
        %% Availability Zones
        subgraph AZ1["Availability Zone 1"]
            %% Public Subnet AZ1
            subgraph PublicSubnet1["Public Subnet AZ1"]
                ALB["Application Load Balancer"]
                BastionHost["Bastion Host"]
                NGW1["NAT Gateway"]
            end
            
            %% Private App Subnet AZ1
            subgraph PrivateSubnet1["Private Subnet AZ1"]
                FrontendNG1["Frontend Node Group"]
                BackendNG1["Backend Node Group"]
            end
            
            %% Private RDS Subnet AZ1
            subgraph RDSSubnet1["Private RDS Subnet AZ1"]
                RDSPrimary["RDS Primary"]
            end
        end
        
        subgraph AZ2["Availability Zone 2"]
            %% Public Subnet AZ2
            subgraph PublicSubnet2["Public Subnet AZ2"]
                NGW2["NAT Gateway"]
            end
            
            %% Private App Subnet AZ2
            subgraph PrivateSubnet2["Private Subnet AZ2"]
                FrontendNG2["Frontend Node Group"]
                BackendNG2["Backend Node Group"]
            end
            
            %% Private RDS Subnet AZ2
            subgraph RDSSubnet2["Private RDS Subnet AZ2"]
                RDSStandby["RDS Standby"]
            end
        end
        
        %% EKS Control Plane
        EKSControl["EKS Control Plane"]
        
        %% Shared Resources
        EFS["EFS File System"]
        S3["S3 Bucket"]
    end
    
    %% Connections
    Internet --> ALB
    Internet --> BastionHost
    ALB --> FrontendNG1
    ALB --> FrontendNG2
    BastionHost --> PrivateSubnet1
    BastionHost --> PrivateSubnet2
    
    %% NAT Gateway Connections
    NGW1 --> Internet
    NGW2 --> Internet
    PrivateSubnet1 --> NGW1
    PrivateSubnet2 --> NGW2
    
    %% EKS Connections
    EKSControl --> FrontendNG1
    EKSControl --> FrontendNG2
    EKSControl --> BackendNG1
    EKSControl --> BackendNG2
    
    %% Database Connections
    BackendNG1 --> RDSPrimary
    BackendNG2 --> RDSPrimary
    RDSPrimary --> RDSStandby
    
    %% Storage Connections
    BackendNG1 --> EFS
    BackendNG2 --> EFS
    BackendNG1 --> S3
    BackendNG2 --> S3

    %% Styling
    classDef public fill:#ff9999
    classDef private fill:#9999ff
    classDef rds fill:#99ff99
    classDef control fill:#ffff99
    
    class PublicSubnet1,PublicSubnet2 public
    class PrivateSubnet1,PrivateSubnet2 private
    class RDSSubnet1,RDSSubnet2 rds
    class EKSControl control
```

## Architecture Components

### Networking
- **VPC**: Custom VPC with defined CIDR range
- **Availability Zones**: Deployed across 2 AZs for high availability
- **Subnets**:
  - Public Subnets (2): For ALB and Bastion hosts
  - Private Application Subnets (2): For EKS worker nodes
  - Private RDS Subnets (2): For database instances

### Compute
- **EKS Cluster**:
  - Managed control plane
  - Frontend Node Groups
  - Backend Node Groups
- **Bastion Host**: For secure access to private resources

### Database
- **RDS**:
  - Primary instance in AZ1
  - Standby instance in AZ2 for high availability

### Storage
- **EFS**: Shared file system for persistent storage
- **S3**: Object storage for application data

### Security
- **Security Groups**: Configured for each component
- **NACLs**: Network access control at subnet level
- **IAM Roles**: For EKS and service accounts

### Load Balancing
- **Application Load Balancer**: For distributing traffic to EKS nodes

### Networking Components
- **Internet Gateway**: For public internet access
- **NAT Gateways**: For private subnet internet access
- **Route Tables**: Configured for public and private subnets

## High Availability Features
1. Multi-AZ deployment
2. Redundant NAT Gateways
3. RDS Multi-AZ configuration
4. EKS worker nodes across multiple AZs
5. Load balancer for traffic distribution
