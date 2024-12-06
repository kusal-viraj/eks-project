# Output the EFS File System ID and Mount Target IPs
output "efs_file_system_id" {
  value = aws_efs_file_system.main_efs.id
}

output "efs_mount_target_ips" {
  value = [for mount_target in aws_efs_mount_target.main_mount_target : mount_target.ip_address]
}
