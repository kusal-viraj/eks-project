



# Create the EFS file system
resource "aws_efs_file_system" "main_efs" {

  creation_token = "${var.env}-efs"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"  # Moves data to Infrequent Access after 30 days
  }
  encrypted = true  # Encrypts the file system at rest

  # Backup policy
  enable_backup_policy = true

  # Replication configuration
  create_replication_configuration = true
  replication_configuration_destination = {
    region = "eu-west-2"
  }

  tags = {
    Name = "${var.env}-efs"
  }
}

# Create Mount Targets in each AZ for the VPC
# Assume that subnet_ids corresponds to subnets in different availability zones

resource "aws_efs_mount_target" "main_mount_target" {

  count         = length(var.efs_subnet_ids)  # Create mount target in each subnet
  file_system_id = aws_efs_file_system.main_efs.id
  subnet_id      = var.efs_subnet_ids[count.index]  # Attach mount target to each subnet
  security_groups = [aws_security_group.main_efs_sg.id]  # Security group for EFS

  # Tags to identify the mount targets
  tags = {
    Name = "${var.env}-efs-mount-target-${count.index}"
  }
}

# Step 4: Security Group for EFS Mount Targets
resource "aws_security_group" "main_efs_sg" {
  name        = "${var.env}-efs-sg"
  description = "Security group for EFS mount targets"
  vpc_id      = var.vpc_id

  # Allow NFS traffic (port 2049) from within the VPC or specific instances
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    #cidr_blocks = ["10.0.0.0/16"]  # Replace with your VPC CIDR or allow only specific sources
    security_group_id = var.backend_nodegroup_sg_id
  }

  # Allow all egress traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.50.0.0/16"]
  }

  tags = {
    Name = "${var.env}-efs-sg"
  }
}

# Step 5: Create EFS Access Point
resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.main_efs.id

  # Define the root directory for this access point
  root_directory {
    path = "/"  # Root directory for this access point
    creation_info {
      owner_gid   = 1000  # Group ID of the owner
      owner_uid   = 1000  # User ID of the owner
      permissions = 755   # Permissions of the root directory
    }
  }

  tags = {
    Name = "${var.env}-efs-access-point"
  }
}
