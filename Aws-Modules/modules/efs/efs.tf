


# Create the EFS file system
resource "aws_efs_file_system" "main_efs" {

  creation_token = "${var.env_name}-efs"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"  # Moves data to Infrequent Access after 30 days
  }
  encrypted = true  # Encrypts the file system at rest

  # Backup policy
  # enable_backup_policy = true

  # Replication configuration
  #  #create_replication_configuration = true
  #  replication_configuration_destination = {
  #    region = "eu-west-2"
  #  }

  tags = {
    Name               = "${var.env_name}-efs"
    Env                = var.env_name
  }
}

# Create Mount Targets in each AZ for the VPC
# Assume that subnet_ids corresponds to subnets in different availability zones

resource "aws_efs_mount_target" "main_mount_target" {

  count         = length(var.efs_subnet_ids)  # Create mount target in each subnet
  file_system_id = aws_efs_file_system.main_efs.id
  subnet_id      = var.efs_subnet_ids[count.index]  # Attach mount target to each subnet
  security_groups = [var.efs_sg_id]  # Security group for EFS

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
    Name = "${var.env_name}-efs-access-point"
    Env  = var.env_name
  }
}
